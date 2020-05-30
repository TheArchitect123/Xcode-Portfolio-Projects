//
//  CitySearchViewModel.swift
//  Telecoms.Swift
//
//  Created by Assassin on 28/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import JSONParserSwift;
import CoreLocation;
import CoreData;

///This class will manage all the business logic of the City Search Page. Business logic (meaning it will exist between the data layer and the rest api layer)
class CitySearchViewModel {
    static var _databaseService : CoreDataService?{
        get{
            return CoreDataService.init();
        }
    }
    
    // MARK: Query Map Information from the Backend
    static func GetCityResults_ByQuery(_ viewController: CitySearchViewController, _ query: String) {
        
        LoaderHelper.ShowLoaderWithMessage("Searching for cities under \"\(query)\"...");
        
        //Invoke a service client on each request, because these will be disposed by ARC
        RestConsumerHelper.Get_DefaultRestConsumer().resource("/weather").withParam("q", "\(query)").withParam("appid", LicenceConstants.WeatherMapsApiKey).loadIfNeeded()?.onSuccess { entity in
            
            let results : Set<WeatherMaster> = Set<WeatherMaster>.init(minimumCapacity: 0);
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                var queryResult : WeatherMaster = try JSONParserSwift.parse(string: rawJson!);
                
                viewController.PartialSearchResults(&queryResult);
            } catch {
                print(error.localizedDescription);
            }
            defer {
                //Last minute clean up...
                
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            
            ToasterHelper.OpenSimpleToast(viewController, "Could not find any results...");
            
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    static func GetCityResults_ByCities(_ viewController: CitySearchViewController, _ query: String, _ coord: CLLocationCoordinate2D) {
        
        LoaderHelper.ShowLoaderWithMessage("Expanding search results for \"\(query)\"...");
        
        //Invoke a service client on each request, because these will be disposed by ARC
        
        
        RestConsumerHelper.Get_DefaultRestConsumer_ForCoord().resource("/find").withParam("lat", "\(coord.latitude)").withParam("lon", "\(coord.longitude)").withParam("cnt", "25").withParam("units", "metric").withParam("appid", LicenceConstants.WeatherMapsApiKey).loadIfNeeded()?.onSuccess { entity -> Void in
            
            do {
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                var queriesResults : WeatherMasters = try JSONParserSwift.parse(string: rawJson!);
                
                viewController.FullSearchResults(&queriesResults);
                ToasterHelper.OpenSimpleToast(viewController, "Successfully retrieved \(queriesResults.cnt) cities...");
            }
            catch{ }
            
            LoaderHelper.DismissLoaderWithDefault();
        }
        .onFailure { (result) -> Void in
            
            ToasterHelper.OpenSimpleToast(viewController, "Could not find any results...");
            
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    //  group?id=524901,703448,2643743&units=metric
}
