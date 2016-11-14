//
//  FirstViewController.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/2/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,
    UIPickerViewDataSource, UIPickerViewDelegate
{
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var technologyPicker: UIPickerView!
    var selectedTechnology:TechnologyTier?
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addLogo()
        
        tblView.delegate = self
        tblView.dataSource = self
        technologyPicker.delegate = self
        technologyPicker.dataSource = self
        
        self.appData.observe(self, properties: [AppData.Property.TopTechnologies, AppData.Property.AllTiers])
        self.appData.loadOverview()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let kp = keyPath {
            switch kp {
            case AppData.Property.AllTiers:
                self.technologyPicker.reloadAllComponents()
            case AppData.Property.TopTechnologies:
                self.tblView.reloadData()
            default: break
            }
        }
    }
    deinit { self.appData.unobserve(self) }
    
    var selectedTechnologies:[TechnologyInfo] {
        return selectedTechnology == nil
            ? appData.topTechnologies
            : appData.topTechnologies.filter { $0.tier! == self.selectedTechnology! }
    }

    /* PickerView */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appData.allTiers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appData.allTiers[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedTechnology = appData.allTiers[row].value
        tblView.reloadData()
    }
    
    /* TableView */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedTechnologies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        if let viewCell = self.tblView.dequeueReusableCell(withIdentifier: "cellHome") as UITableViewCell? {
            cell = viewCell
        } else {
            cell = UITableViewCell()
        }

        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        let tech = selectedTechnologies[indexPath.row]
        cell.textLabel?.text = "\(tech.name!) (\(tech.stacksCount!))"
        cell.textLabel!.font = cell.textLabel!.font.withSize(Style.tableCellTitleSize)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Style.tableCellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = selectedTechnologies[indexPath.row]
        self.navigationController?.openTechnology(selected.slug!)
    }
}

