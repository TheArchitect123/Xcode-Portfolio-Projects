//
//  SearchWeatherSource.swift
//  Telecoms.Swift
//
//  Created by Assassin on 28/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//


import Foundation
import UIKit;
import Material;

class SearchWeatherSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //This will be passed in by the Address Search Controller that will then invoke the view model
    var completionHandler: (Int)->Void = {
        (arg: Int) -> Void in
    }
    
    init(_handler: @escaping (Int) -> Void) {
        completionHandler = _handler;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Items.count;
        return 2;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = TableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "defaultCell");
        
        ConfigureCustomCell(defaultCell);
        
        //Bind the data
        defaultCell.textLabel?.text = "9:32am";
        defaultCell.detailTextLabel?.text = "Sydney";
        
        
        return defaultCell;
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        NavigationHelper.GetActiveViewController()?.presentedViewController?.dismiss(animated: true, completion: nil);
        
        NavigationHelper.GetActiveViewController()?.NavigateToPage(NavigationHelper.GetCityDetailViewController());
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            
             let addItemAction = UITableViewRowAction(style: .normal, title: "Add Item") { (action, indexPath) in
                           
                //Dismiss the Search Controller
                NavigationHelper.GetActiveViewController()?.presentedViewController?.dismiss(animated: true, completion: nil);
                
                //Then run some business logic via the view model that will add the item to the CoreData model, so next time it will show up on the dashboard
                
                //This will need to pass the ID of the object that is cached in the array
                self.completionHandler(0);
                      };
            
            addItemAction.backgroundColor = ColorHelper.DarkThemeBackground();
            
            return  [addItemAction]
    }
    
    
    func ConfigureCustomCell(_ cell: UITableViewCell){
         cell.addBorders();
        cell.textLabel?.font = UIFont.init(name: "Roboto-Light", size: 20.0);
        cell.detailTextLabel?.font = UIFont.init(name: "Roboto-Light", size: 26.0);
        cell.accessoryType = .detailButton;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //On Selection this will navigate to the detail page
        NavigationHelper.GetActiveViewController()?.NavigateToPage(CityDetailViewController.init());
    }
}
