//
//  CityDetailsBottomDrawerViewModel.swift
//  Telecoms.Swift
//
//  Created by Assassin on 29/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import JSONParserSwift;

class CityDetailsBottomDrawerViewModel {
    
    // MARK: Query Map Information from the Backend
    static func GetCityResults_ByName(_ viewController: CityDetailsBottomDrawerController, _ city: String) {
        
        LoaderHelper.ShowLoaderWithMessage("Loading data for \(city)...");
        
        //Invoke a service client on each request, because these will be disposed by ARC
        RestConsumerHelper.Get_DefaultRestConsumer().resource("/weather").withParam("q", "\(city)").withParam("appid", LicenceConstants.WeatherMapsApiKey).loadIfNeeded()?.onSuccess { entity in
            
            let results : Set<WeatherMaster> = Set<WeatherMaster>.init(minimumCapacity: 0);
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                var queryResult : WeatherMaster = try JSONParserSwift.parse(string: rawJson!);
                
               // viewController.ReturnedCities(&queryResult);
            } catch {
                print(error.localizedDescription);
            }
            defer {
                //Last minute clean up...
                
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            
            ToasterHelper.OpenSimpleToast(viewController, "Failed to synchronise. Weather data has been taken off the local memory cache");
            
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    static func GetCityResults_ByCities(_ viewController: CityDetailsBottomDrawerController, _ ids: String) {
        
        //This call needs to make sure to read the database connection and to check all the ids that exist on the device. It then needs to concatenate these into the string IDs
        LoaderHelper.ShowLoaderWithMessage("Synchronising");
        
        //Invoke a service client on each request, because these will be disposed by ARC
        RestConsumerHelper.Get_DefaultRestConsumer_ForBulk().resource("/group").withParam("id", ids).withParam("appid", LicenceConstants.WeatherMapsApiKey).withParam("units", "metric").loadIfNeeded()?.onSuccess { entity -> Void in
            
            do {
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                let queriesResults : WeatherMasters = try JSONParserSwift.parse(string: rawJson!);
                
                viewController.ReturnedCities(&queriesResults.list);
                ToasterHelper.OpenSimpleToast(viewController, "Successfully updated weather data");
            }
            catch{ }
            
            defer{
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            
            ToasterHelper.OpenSimpleToast(viewController, "Could not find any results...");
            
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
}

