//
//  DashboardWeatherSource.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Material;

class DashboardWeatherSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Items.count;
        return 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let contextItem = UIContextualAction(style: .normal, title: "Leading & .normal") { (contextualAction, view, boolValue) in
//            print("Leading Action style .normal")
//        }
//        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
//
//        return swipeActions
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let contextItem = UIContextualAction(style: .destructive, title: "Trailing & .destructive") { (contextualAction, view, boolValue) in
//            print("Trailing Action style .destructive")
//        }
//        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
//
//        return swipeActions
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = TableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "defaultCell");
        
        
       // defaultCell.textLabel?.text = Items[indexPath.row].EnglishPhrase;
       // defaultCell.detailTextLabel?.text = Items[indexPath.row].FrenchPhrase;
        
        return defaultCell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let action = UIContextualAction(style: .normal, title: "Unfavorite",
//                                        handler: { (action, view, completionHandler) in
//                                            // Update data source when user taps action
//
//                                            completionHandler(true)
//        });
//
//        action.image = UIImage(named: "MenuIcon")
//        action.backgroundColor = .green;
//        let configuration = UISwipeActionsConfiguration(actions: [action])
//        return configuration
//    }
}
