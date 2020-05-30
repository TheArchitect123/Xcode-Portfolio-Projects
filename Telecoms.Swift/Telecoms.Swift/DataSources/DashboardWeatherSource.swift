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
import MapKit;
import SwiftPopup;

class DashboardWeatherSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var deleteItemHandler: (Int)->Void = {
        (arg: Int) -> Void in
    }
    
    var previewItemHandler: (Int)->Void = {
        (arg: Int) -> Void in
    }
    
    //When the user completes their search, a rest api is called to retrieve the results & persist the previous results into the db
    var Cities: [WeatherMaster]?;
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Cities);
        
        return Cities != nil ? Cities!.count : 0;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = TableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "defaultCell");
        defaultCell.addBorders();
        
        ConfigureCustomCell(defaultCell);
        defaultCell.accessoryView = RenderTemperatureControl("\(Int(Cities![indexPath.row].main.temp))°");
        
        //Bind the data
        
        defaultCell.textLabel?.text = "Wind Speed - \(Cities![indexPath.row].wind.speed)m/s";
        defaultCell.detailTextLabel?.text = "\(Cities![indexPath.row].name)";
        
        return defaultCell;
    }
    
    func ConfigureCustomCell(_ cell: UITableViewCell){
        cell.textLabel?.font = UIFont.init(name: "Roboto-Light", size: 20.0);
        cell.detailTextLabel?.font = UIFont.init(name: "Roboto-Light", size: 26.0);
        cell.accessoryType = .none;
    }
    
    fileprivate func RenderTemperatureControl(_ temperatureValue: String) -> UILabel {
        
        let temperature = UILabel.init();
        temperature.font = UIFont.init(name: "Roboto-Light", size: 34.0);
        temperature.text = temperatureValue;
        temperature.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: CGSize.init(width: 80, height: 40));
        
        return temperature;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //On Selection this will navigate to the detail page
        
        let controller = NavigationHelper.GetCityDetailViewController();
        controller.CityID = self.Cities![indexPath.row].id;
        controller.CityName = self.Cities![indexPath.row].name;
        controller.CityLocation = CLLocationCoordinate2D.init(latitude: self.Cities![indexPath.row].coord.lat, longitude: self.Cities![indexPath.row].coord.lon);
        
        NavigationHelper.GetActiveViewController()?.NavigateToPage(controller);
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath)
        -> [UITableViewRowAction]? {
            
            let openMapsItemAction = UITableViewRowAction(style: .normal, title: "Open Maps") { (action, indexPath) in
                
                //Opens up the local maps app, to show the user where the city is on the user's device
                
                let coordinates = CLLocationCoordinate2D.init(latitude: self.Cities![indexPath.row].coord.lat, longitude: self.Cities![indexPath.row].coord.lon);
                
                MapsHelper.openMapForPlace(nameOfCity: self.Cities![indexPath.row].name, location: coordinates);
            };
            
            openMapsItemAction.backgroundColor = ColorHelper.ForestGreen();
            
            let previewItemAction = UITableViewRowAction(style: .normal, title: "Preview") { (action, indexPath) in
                
                //This will need to pass the ID of the object that is cached in the array
                let controller = NavigationHelper.GetCityDetailViewController();
                controller.CityID = self.Cities![indexPath.row].id;
                controller.CityName = self.Cities![indexPath.row].name;
                controller.CityLocation = CLLocationCoordinate2D.init(latitude: self.Cities![indexPath.row].coord.lat, longitude: self.Cities![indexPath.row].coord.lon);
                
                print("ID \( controller.CityID)");
                print("ID \( self.Cities![indexPath.row].sys.id)");
                
                NavigationHelper.GetActiveViewController()?.NavigateToPage(controller);
            };
            
            previewItemAction.backgroundColor = ColorHelper.DarkThemeBackground();
            
            let deleteItemAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                //This will need to pass the ID of the object that is cached in the array
                
                self.Cities!.remove(at: indexPath.row);
                tableView.reloadData();
                
                self.deleteItemHandler(Int(self.Cities![indexPath.row].sys.id));
            };
            
            deleteItemAction.backgroundColor = UIColor.red;
            
            return [openMapsItemAction, previewItemAction, deleteItemAction];
    }
}
