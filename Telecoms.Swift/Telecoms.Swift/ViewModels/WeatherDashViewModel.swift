//
//  WeatherDashViewModel.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import JSONParserSwift;

class WeatherDashViewModel {
    
    static func GetCityResults_ByCities(_ viewController: WeatherDashController, _ ids: String) {
        
        //This call needs to make sure to read the database connection and to check all the ids that exist on the device. It then needs to concatenate these into the string IDs
        LoaderHelper.ShowLoaderWithMessage("Preparing default cities and refreshing disk cache...");
        
        //Invoke a service client on each request, because these will be disposed by ARC
        RestConsumerHelper.Get_DefaultRestConsumer_ForBulk().resource("/group").withParam("id", ids).withParam("appid", LicenceConstants.WeatherMapsApiKey).withParam("units", "metric").loadIfNeeded()?.onSuccess { entity -> Void in
            
            do {
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                let queriesResults : WeatherMasters = try JSONParserSwift.parse(string: rawJson!);
                
                viewController.ReturnedCities( &queriesResults.list);
                ToasterHelper.OpenSimpleToast(viewController, "Successfully retrieved \(queriesResults.cnt) cities...");
            }
            catch{ }
            
            defer{
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            
            ToasterHelper.OpenSimpleToast(viewController, "Could not find any results...");
            
            viewController.ResetCitiesForEmptyItems();
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
}
