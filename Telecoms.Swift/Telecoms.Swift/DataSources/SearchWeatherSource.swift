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
import MapKit;

class SearchWeatherSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //When the user completes their search, a rest api is called to retrieve the results & persist the previous results into the db
    var SearchResults: [WeatherMaster]?;
    
    //This will be passed in by the Address Search Controller that will then invoke the view model
    var completionHandler: (Int)->Void = {
        (arg: Int) -> Void in
    }
    
    var deletionHandler: (Int)->Void = {
        (arg: Int) -> Void in
    }
    
    var previewHandler: (Int)->Void = {
        (arg: Int) -> Void in
    }
    
    
    init(_completionHandler: @escaping (Int) -> Void,
         _deletionHandler: @escaping (Int) -> Void,
         _previewHandler: @escaping (Int) -> Void) {
        completionHandler = _completionHandler;
        deletionHandler = _deletionHandler;
        previewHandler = _previewHandler;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Items.count;
        return SearchResults != nil ? SearchResults!.count : 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = TableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "defaultCell");
        defaultCell.addBorders();
        
        ConfigureCustomCell(defaultCell);
        
        //Bind the data
        defaultCell.textLabel?.text = "Currently  \(Int(SearchResults![indexPath.row].main.temp))º";
        defaultCell.detailTextLabel?.text = "\(SearchResults![indexPath.row].name)";
        
        return defaultCell;
    }
    
    func FormatTimeOfCity(_ date: Date?) -> String {
        if(date != nil) {
            return "\(date!.GetCurrentTime(date: date!).0):\(date!.GetCurrentTime(date: date!).1)";
        }
        
        return "";
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        let searchResult = self.SearchResults![indexPath.row];
        MapsHelper.openMapForPlace(nameOfCity: searchResult.name, location: CLLocationCoordinate2D.init(latitude: searchResult.coord.lat, longitude: searchResult.coord.lon))
    }
    
    func AddNewItem(cityId: Int){
        //Then run some business logic via the view model that will add the item to the CoreData model, so next time it will show up on the dashboard
        //This will need to pass the ID of the object that is cached in the array
        
        CitySearchViewModel._databaseService!.PersistDataOnDisk(cityID: cityId);
        
        self.completionHandler(cityId);
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            
            let addItemAction = UITableViewRowAction(style: .normal, title: "Add Item") { (action, indexPath) in
                
                self.AddNewItem(cityId: self.SearchResults![indexPath.row].id);
            };
            
            addItemAction.backgroundColor = ColorHelper.DarkThemeBackground();
            
            let openMapsItemAction = UITableViewRowAction(style: .normal, title: "Open Maps") { (action, indexPath) in
                
                //Opens up the local maps app, to show the user where the city is on the user's device
                
                let coordinates = CLLocationCoordinate2D.init(latitude: self.SearchResults![indexPath.row].coord.lat, longitude: self.SearchResults![indexPath.row].coord.lon);
                
                MapsHelper.openMapForPlace(nameOfCity: self.SearchResults![indexPath.row].name, location: coordinates);
            };
            
            openMapsItemAction.backgroundColor = ColorHelper.ForestGreen();
            
            //            if(!SearchResults![indexPath.row].existsOnDatabase){
            //                return [addItemAction, openMapsItemAction];
            //            }
            //            else {
            //                return [openMapsItemAction];
            //            }
            //
            return [addItemAction, openMapsItemAction];
    }
    
    
    func ConfigureCustomCell(_ cell: UITableViewCell){
        cell.addBorders();
        cell.textLabel?.font = UIFont.init(name: "Roboto-Light", size: 20.0);
        cell.detailTextLabel?.font = UIFont.init(name: "Roboto-Light", size: 26.0);
        cell.accessoryType = .detailButton;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //On Selection this will navigate to the detail page
       self.AddNewItem(cityId: self.SearchResults![indexPath.row].id);
    }
}
