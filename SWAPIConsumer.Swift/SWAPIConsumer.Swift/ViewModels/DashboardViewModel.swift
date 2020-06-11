//
//  DashboardViewModel.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Resolver;
import JSONParserSwift;

class DashboardViewModel : NSObject {
    @LazyInjected var _database: DatabaseService;
    
    //There is a listener on the dashboard page, which will wait for all 6 films, to return some information.
    //When ID 6 is returned back to the dashboard controller, the controller will merge the character dto information and
    //present it in a form of a dialogue
    func getCharactersForSpecifiedFilms(actors: Array<String>, actionResults:@escaping(FilmsDto?) -> Void){
        
        //Normally, there would be an api that I would create that receives an array of these character information
        //However the star wars api, does not have it. This is not efficient, because now I have to make a request for every single character, and wait for the merge. This will add time to the user to wait, and what happens when there are too many requests happening at once for the device? Most likely the connection to the remote server (via the Session Configuration) will be disconnected. If the connection fails, then the whole transaction needs to run ATOMICALLY
        LoaderHelper.ShowLoaderWithMessage("Loading all Actors for film");
        
        for actor in actors{
            let consumer = RestConsumerHelper.Get_DefaultRestConsumerWithoutBase();
                //Invoke a service client on each request, because these will be disposed by ARC
                //loadIfNeeded() will enforce only a single request, for each resource. This is managed underthehood by the siesta rest client framework
                consumer.resource(actor).loadIfNeeded()?.onSuccess { entity in
                    
                    //Convert these data bytes into a json string and map into the json model for processing
                    do {
                        
                        let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                        
                        actionResults(try? JSONParserSwift.parse(string: rawJson!));
                    } catch {
                        print(error.localizedDescription);
                    }
                }
                .onFailure { (result) -> Void in
                    SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
                };
        }
    }
    
    func getResultsForFilmsRoot(actionResults:@escaping(FilmsDto?) -> Void){
           
           LoaderHelper.ShowLoaderWithMessage("Loading all Films");
           
           let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
           //Invoke a service client on each request, because these will be disposed by ARC
           consumer.resource("/films").loadIfNeeded()?.onSuccess { entity in
               
               //Convert these data bytes into a json string and map into the json model for processing
               do {
                   
                   let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                   
                   actionResults(try? JSONParserSwift.parse(string: rawJson!));
               } catch {
                   print(error.localizedDescription);
               }
            
            LoaderHelper.DismissLoaderWithDefault();
           }
           .onFailure { (result) -> Void in
            LoaderHelper.DismissLoaderWithDefault();
               SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
           };
       }
    
    
}
