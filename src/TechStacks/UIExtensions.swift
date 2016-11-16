//
//  StoryBoardExtensions.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/3/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation
import UIKit

// Reusable code shared by different views
public enum MainTab : Int
{
    case home = 0
    case techStacks = 1
    case technologies = 2
}

public struct Style
{
    public static let titleSize:CGFloat = {
        return iPad() ? 30 : 20
    }()
    
    public static let detailSize:CGFloat = {
        return iPad() ? 16 : 12
    }()

    public static let headingSize:CGFloat = {
        return iPad() ? 26 : 16
    }()

    public static let tableCellHeight:CGFloat = {
        return iPad() ? 70 : 40
    }()
    
    public static let tableCellTitleSize:CGFloat = {
        return iPad() ? 26 : 16
    }()
    
    public static let tableCellDetailSize:CGFloat = {
        return iPad() ? 20 : 14
    }()
    
    public static let padding:CGFloat = {
        return iPad() ? 16 : 8
    }()
    
    public static let techLogoHeight:CGFloat = {
        return iPad() ? 120 : 75
    }()
    
    public static let screenshotHeight:CGFloat = {
        return iPad() ? 420 : 240
    }()
    
    public static let screenshotWidth:CGFloat = {
        return screenshotHeight * 1.25
    }()
}

extension CGFloat
{
    var lineHeight:CGFloat {
        return self + 4
    }
}

func iPad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}

func deviceSizes(_ iphone:CGFloat, ipad:CGFloat) -> CGFloat {
    return UIDevice.current.userInterfaceIdiom == .pad ? ipad : iphone
}

extension UIStoryboard
{    
    func headerViewController() -> UIViewController {
        let headerController = self.instantiateViewController(withIdentifier: "HeaderViewController") as! HeaderViewController
        let view:UIView = headerController.view!
        var frame = view.frame
        frame.size.height = 60
        view.frame = frame
        
        return headerController
    }
    
    var tabControler:UITabBarController {
        let window = UIApplication.shared.keyWindow!
        return window.rootViewController as! UITabBarController
    }
    
    func openTechnologyStack(_ slug:String, goBackToTab:MainTab? = nil) {
        let detail = self.instantiateViewController(withIdentifier: "TechnologyStackDetailViewController") as! TechnologyStackDetailViewController
        detail.slug = slug
        if goBackToTab != nil {
            detail.goBackToTab = goBackToTab
        }
        
        let navController = tabControler.navigationControllerFor(MainTab.techStacks)!
        navController.popToRootViewController(animated: true)
        navController.pushViewController(detail, animated: true)
        tabControler.switchTab(MainTab.techStacks)
    }
    
    func openTechnology(_ slug:String, goBackToTab:MainTab? = nil) {
        let detail = self.instantiateViewController(withIdentifier: "TechnologyDetailViewController") as! TechnologyDetailViewController
        detail.slug = slug
        if goBackToTab != nil {
            detail.goBackToTab = goBackToTab
        }

        let navController = tabControler.navigationControllerFor(MainTab.technologies)!
        navController.popToRootViewController(animated: true)
        navController.pushViewController(detail, animated: true)
        tabControler.switchTab(MainTab.technologies)
    }
    
    func switchTab(_ tab:MainTab) {
        if let window = UIApplication.shared.keyWindow {
            let tabController = window.rootViewController as? UITabBarController
            tabController?.switchTab(tab)
        }
    }
}

extension UIView
{
    var appData:AppData {
        return (UIApplication.shared.delegate as! AppDelegate).appData
    }
}

extension UIViewController
{
    var appData:AppData {
        return (UIApplication.shared.delegate as! AppDelegate).appData
    }
    
    func openServiceStack() {
        self.storyboard?.openTechnology("servicestack")
    }
    
    func addLogo() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "logo"), landscapeImagePhone: nil, style: UIBarButtonItemStyle.done, target: self, action: #selector(UIViewController.openServiceStack))
    }
}

extension UINavigationController
{
    func openTechnologyStack(_ slug:String) {
        let detail = self.storyboard!.instantiateViewController(withIdentifier: "TechnologyStackDetailViewController") as! TechnologyStackDetailViewController
        detail.slug = slug
        detail.navigationController?.navigationBar.backItem?.title = "Back"
        self.pushViewController(detail, animated: true)
    }
    
    func openTechnology(_ slug:String) {
        let detail = self.storyboard!.instantiateViewController(withIdentifier: "TechnologyDetailViewController") as! TechnologyDetailViewController
        detail.slug = slug
        detail.navigationController?.navigationBar.backItem?.title = "Back"
        self.pushViewController(detail, animated: true)
    }
}

extension UITabBarController
{
    func switchTab(_ tab:MainTab) {
        self.selectedIndex = tab.rawValue
    }
    
    func currentNavigationController() -> UINavigationController? {
        return self.viewControllers![self.selectedIndex] as? UINavigationController
    }
    
    func navigationControllerFor(_ tab:MainTab) -> UINavigationController? {
        return self.viewControllers![tab.rawValue] as? UINavigationController
    }
    
    var currentTab:MainTab {
        return MainTab(rawValue: self.selectedIndex)!
    }
}

extension UIImageView {
    @discardableResult func loadAsync(_ url:String?, defaultImage:String? = nil, withSize:CGSize? = nil) -> Promise<UIImage?> {
        if defaultImage != nil {
            self.image = self.appData.imageCache[defaultImage!]
        } else {
            self.image = nil
        }
        
        if url == nil {
            return Promise<UIImage?> { (complete, reject) in complete(nil) }
        }
        
        return self.appData.loadImageAsync(url!)
            .then {(img:UIImage?) -> UIImage? in
                if img != nil {
                    
                    if withSize != nil {
                        self.image = img?.scaledInto(withSize!)
                    } else {
                        self.image = img
                    }
                }
                return self.image
            }
    }
}

extension CGFloat
{
    public func toHexColor(_ rgbValue:UInt32) -> UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
}

extension UIImage
{
    func scaledInto(_ bounds:CGSize) -> UIImage
    {
        var scaledSize:CGSize = bounds
        
        let ratioX = bounds.width / self.size.width
        let ratioY = bounds.height / self.size.height
        let useRatio = min(ratioX, ratioY)
        
        scaledSize.width = self.size.width * useRatio
        scaledSize.height = self.size.height * useRatio
        
        UIGraphicsBeginImageContextWithOptions(scaledSize, false, 0.0)
        let scaledImageRect = CGRect(x: 0.0, y: 0.0, width: scaledSize.width, height: scaledSize.height)
        self.draw(in: scaledImageRect)
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
}

extension UILabel
{
    func setFrame(_ x:CGFloat, y:CGFloat, width:CGFloat, height:CGFloat) {
        self.frame = self.frame
    }
}

extension String {
    func toHumanFriendlyUrl() -> String {
        if self.length == 0 {
            return ""
        }
        let url = splitOn(first:"://").last!
        return url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
    }
}

