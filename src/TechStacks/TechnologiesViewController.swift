//
//  TechnologiesViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/4/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation

class TechnologiesViewController: UIViewController, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating,
UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var searchController: UISearchController!
    var resultsController:TechnologySearchResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLogo()

        tableView.delegate = self
        tableView.dataSource = self
        
        resultsController = TechnologySearchResultsController()
        resultsController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.text = appData.search
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.delegate = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        appData.observe(self, properties: [AppData.Property.AllTechnologies])
        appData.loadAllTechnologies()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let kp = keyPath {
            switch kp {
            case AppData.Property.AllTechnologies:
                self.tableView.reloadData()
            default: break
            }
        }
    }
    deinit { self.appData.unobserve(self) }
    
    func searchText() -> String {
        if let text = searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces) {
            return text
        }
        return ""
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let search = searchText()
        if search.length > 0 {
            appData.searchTechnologies(search)
                .then { r in
                    if search != self.searchText() {
                        return //stale results
                    }
                    
                    self.resultsController.filteredResults = r.results
                    self.resultsController.tableView.reloadData()
                }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appData.allTechnologies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.createTechnologyTableCell(appData.allTechnologies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = tableView == self.tableView
            ? appData.allTechnologies[indexPath.row]
            : resultsController.filteredResults[indexPath.row]

        // Note: Should not be necessary but current iOS 8.0 bug requires it.
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: false)

        self.storyboard?.openTechnology(selected.slug!)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Style.tableCellHeight
    }
}

class TechnologySearchResultsController : UITableViewController {
    var filteredResults = [Technology]()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.createTechnologyTableCell(filteredResults[indexPath.row])
    }
}

extension UITableView
{
    func createTechnologyTableCell(_ result:Technology) -> UITableViewCell {
        
        var cell: UITableViewCell
        if let viewCell = self.dequeueReusableCell(withIdentifier: "cellTechnology") as UITableViewCell? {
            cell = viewCell
        } else {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellTechnology")
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell.textLabel?.text = result.name
        cell.textLabel!.font = cell.textLabel!.font.withSize(Style.tableCellTitleSize)
        
        cell.detailTextLabel?.text = result.Description
        cell.detailTextLabel?.textColor = UIColor.gray
        cell.detailTextLabel!.font = cell.detailTextLabel!.font.withSize(Style.tableCellDetailSize)

        return cell
    }
}
