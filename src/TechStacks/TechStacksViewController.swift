//
//  SecondViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/2/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit

class TechStacksViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,
    UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var searchController: UISearchController!
    var resultsController:TechnologyStackSearchResultsController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLogo()

        tableView.delegate = self
        tableView.dataSource = self
        
        resultsController = TechnologyStackSearchResultsController()
        resultsController.tableView.delegate = self

        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.text = appData.search
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true

        appData.observe(self, properties: [AppData.Property.AllTechnologyStacks])
        appData.loadAllTechStacks()
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let kp = keyPath {
            switch kp {
            case AppData.Property.AllTechnologyStacks:
                self.tableView.reloadData()
            default: break
            }
        }
    }
    
    deinit { self.appData.unobserve(self) }

    func searchText() -> String {
        if let text = searchController.searchBar.text?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) {
            return text
        }
        return ""
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let search = searchText()
        if search.length > 0 {
            appData.searchTechStacks(search)
                .then { r -> Void in
                    if search != self.searchText() {
                        return //stale results
                    }
                    
                    self.resultsController.filteredResults = r.results
                    self.resultsController.tableView.reloadData()
                }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.allTechnologyStacks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.createTechnologyStackTableCell(appData.allTechnologyStacks[indexPath.row])
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selected = tableView == self.tableView
            ? appData.allTechnologyStacks[indexPath.row]
            : resultsController.filteredResults[indexPath.row]
        
        // Note: Should not be necessary but current iOS 8.0 bug requires it.
        tableView.deselectRowAtIndexPath(tableView.indexPathForSelectedRow!, animated: false)

        self.storyboard?.openTechnologyStack(selected.slug!)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Style.tableCellHeight
    }
}

class TechnologyStackSearchResultsController : UITableViewController {
    var filteredResults = [TechnologyStack]()

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.createTechnologyStackTableCell(filteredResults[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return Style.tableCellHeight
    }
}

extension UITableView
{
    func createTechnologyStackTableCell(result:TechnologyStack) -> UITableViewCell {
        
        let cell: UITableViewCell
        if let viewCell = self.dequeueReusableCellWithIdentifier("cellTechnologyStack") as UITableViewCell? {
            cell = viewCell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellTechnologyStack")
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = result.name
        cell.textLabel!.font = cell.textLabel!.font.fontWithSize(Style.tableCellTitleSize)
        
        cell.detailTextLabel?.text = result.Description
        cell.detailTextLabel?.textColor = UIColor.grayColor()
        cell.detailTextLabel!.font = cell.detailTextLabel!.font.fontWithSize(Style.tableCellDetailSize)

        return cell
    }
}
