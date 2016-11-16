//
//  TechnologyStackDetailViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/5/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation

class TechnologyStackDetailViewController : UIViewController {
    var slug:String!
    var goBackToTab:MainTab?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UITextView!
    @IBOutlet weak var imgScreenshot: UIImageView!
    @IBOutlet var scrollView: UIScrollView!
    
    var result:TechStackDetails?
    
    @IBAction func btnAppUrlGo(_ sender: AnyObject) {
        if result?.appUrl != nil {
            if let url = URL(string: result!.appUrl!) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if goBackToTab != nil {
            self.storyboard?.switchTab(goBackToTab!)
        }
    }
    
    override func viewDidLoad() {
        let name = slug.replace("-", withString: " ")
        self.title = "loading \(name)..."
        lblName.text = "loading \(name)..."

        appData.loadTechnologyStack(slug)
            .then { r in
                if let result = r.result {
                    self.result = result
                    self.title = "TechStack"
                    self.lblName.text = result.name

                    self.lblDescription.text = result.Description
                    
                    self.calculateLayout()
                    
                    self.imgScreenshot.loadAsync(result.screenshotUrl, withSize:self.imgScreenshot.frame.size)
                    
                    self.loadTechnologies(r.result!.technologyChoices)
                }
            }
    }
    
    func calculateLayout() {
        let pad = Style.padding
        
        let fullWidth = view.frame.width
        let innerWidth = fullWidth - (pad * 2)
        
        lblName.frame = CGRect(x: pad, y: pad, width: innerWidth, height: Style.titleSize.lineHeight)
        lblName.font = lblName.font.withSize(Style.titleSize)

        lblDescription.frame = CGRect(x: pad, y:pad + lblName.frame.size.height + pad, width:innerWidth, height: Style.detailSize.lineHeight)
        if let f = lblDescription.font?.withSize(Style.detailSize) {
            lblDescription.font = f
        }
        lblDescription.sizeToFit()

        imgScreenshot.frame = CGRect(
            x: (view.frame.size.width - Style.screenshotWidth) / 2,
            y: lblDescription.frame.origin.y + lblDescription.frame.height + pad,
            width: Style.screenshotWidth,
            height: Style.screenshotHeight)
        
        let btnAppUrl = UIButton(type: UIButtonType.system)
        btnAppUrl.frame = CGRect(x: imgScreenshot.frame.origin.x,
                y: imgScreenshot.frame.origin.y + imgScreenshot.frame.size.height,
                width: imgScreenshot.frame.width,
                height: Style.detailSize.lineHeight)
        btnAppUrl.setTitle(result!.appUrl?.toHumanFriendlyUrl(), for: UIControlState())
        btnAppUrl.addTarget(self, action: #selector(TechnologyStackDetailViewController.btnAppUrlGo(_:)), for: .touchUpInside)
        scrollView.addSubview(btnAppUrl)
    }
    
    var techSlugs = [String]()

    func loadTechnologies(_ techChoices:[TechnologyInStack]) {
        let imageUrls = techChoices.filter { $0.logoUrl != nil }.map { $0.logoUrl! }
        let fullWidth = self.view.frame.width
        
        self.appData.loadAllImagesAsync(imageUrls)
            .then { (images:[String:UIImage?]) -> Void in
                let pad = Style.padding
                let btnAppUrlSize:CGFloat = 20
                var startPos = self.imgScreenshot.frame.origin.y + self.imgScreenshot.frame.size.height + pad + btnAppUrlSize
                
                for tier in self.appData.allTiers {
                    let techologiesInTier = techChoices.filter { $0.tier == tier.value }
                    if techologiesInTier.count > 0 {
                        startPos += pad
                        let title = UILabel(frame: CGRect(x: pad, y: startPos + pad, width: fullWidth, height: Style.headingSize.lineHeight))
                        title.font = UIFont(name: title.font.fontName, size: Style.headingSize)
                        startPos += Style.headingSize
                        
                        title.text = tier.title
                        title.textColor = UIColor.lightGray
                        self.scrollView.addSubview(title)

                        startPos += pad
                        var i = 0
                        for tech in techologiesInTier {
                            if tech.logoUrl == nil {
                                continue
                            }
                            if let img = images[tech.logoUrl!] {
                                if img == nil {
                                    continue
                                }
                                i += 1
                                startPos += pad
                                let x = i % 2 == 1 ? pad : fullWidth / 2 + pad
                                let imgBtn = UIButton(frame: CGRect(x: x, y: startPos, width: fullWidth / 2 - (2 * pad), height: Style.techLogoHeight))
                                if i % 2 == 0 {
                                    startPos += Style.techLogoHeight
                                }

                                imgBtn.setImage(img!.scaledInto(imgBtn.frame.size), for: UIControlState())
                                self.techSlugs.append(tech.slug!)
                                imgBtn.tag = self.techSlugs.count - 1
                                imgBtn.addTarget(self,
                                    action: #selector(TechnologyStackDetailViewController.onTechnologySelected(_:)),
                                    for: .touchUpInside)
                                
                                self.scrollView.addSubview(imgBtn)
                            }
                        }
                        if i % 2 == 1 {
                            startPos += Style.techLogoHeight
                        }
                    }
                }
                
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: startPos)
            }
    }
    
    func onTechnologySelected(_ sender:UIButton) {
        let slug = techSlugs[sender.tag]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationController?.openTechnology(slug)
    }
    
}
