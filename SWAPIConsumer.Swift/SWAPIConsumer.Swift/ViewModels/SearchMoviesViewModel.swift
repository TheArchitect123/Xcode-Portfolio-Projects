//
//  SearchViewModel.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Siesta;
import JSONParserSwift;
import Resolver;

class SearchMoviesViewModel : NSObject{
    lazy var _database: DatabaseService = DatabaseService.init();
    
    func searchResultsForPeopleQuery(query: String, actionResults:@escaping(PeopleDto?) -> Void) {
        LoaderHelper.ShowLoaderWithMessage("Searching for People under \"\(query)\"...");
        
        let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
        //Invoke a service client on each request, because these will be disposed by ARC
        consumer.resource("/people").withParam("search", "\(query)").loadIfNeeded()?.onSuccess { entity in
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                actionResults(try? JSONParserSwift.parse(string: rawJson!));
            } catch {
                print(error.localizedDescription);
            }
            defer {
                
                //Last minute clean up...
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    
    
    func searchResultsForFilmsQuery(query: String, actionResults:@escaping(FilmsDto?) -> Void){
        
        LoaderHelper.ShowLoaderWithMessage("Searching for Films under \"\(query)\"...");
        
        let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
        //Invoke a service client on each request, because these will be disposed by ARC
        consumer.resource("/films").withParam("search", "\(query)").loadIfNeeded()?.onSuccess { entity in
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                actionResults(try? JSONParserSwift.parse(string: rawJson!));
            } catch {
                print(error.localizedDescription);
            }
            defer {
                
                //Last minute clean up...
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    func searchResultsForFilmsRoot(actionResults:@escaping(FilmsDto?) -> Void){
        
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
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
        };
    }
    
    func searchResultsForPlanetsQuery(query: String, actionResults:@escaping(PlanetsDto?) -> Void){
        LoaderHelper.ShowLoaderWithMessage("Searching for Planets under \"\(query)\"...");
        
        let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
        //Invoke a service client on each request, because these will be disposed by ARC
        consumer.resource("/planets").withParam("search", "\(query)").loadIfNeeded()?.onSuccess { entity in
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                actionResults(try? JSONParserSwift.parse(string: rawJson!));
            } catch {
                print(error.localizedDescription);
            }
            defer {
                
                //Last minute clean up...
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    func searchResultsForSpeciesQuery(query: String, actionResults:@escaping(SpeciesDto?) -> Void) {
        LoaderHelper.ShowLoaderWithMessage("Searching for Species under \"\(query)\"...");
        
        let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
        //Invoke a service client on each request, because these will be disposed by ARC
        consumer.resource("/species").withParam("search", "\(query)").loadIfNeeded()?.onSuccess { entity in
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                actionResults(try? JSONParserSwift.parse(string: rawJson!));
            } catch {
                print(error.localizedDescription);
            }
            defer {
                
                //Last minute clean up...
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
            LoaderHelper.DismissLoaderWithDefault();
        };
        
    }
    
    func searchResultsForStarShipsQuery(query: String, actionResults:@escaping(StarshipsDto?) -> Void){
        LoaderHelper.ShowLoaderWithMessage("Searching for StarShips under \"\(query)\"...");
        
        let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
        //Invoke a service client on each request, because these will be disposed by ARC
        consumer.resource("/starships").withParam("search", "\(query)").loadIfNeeded()?.onSuccess { entity in
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                actionResults(try? JSONParserSwift.parse(string: rawJson!));
            } catch {
                print(error.localizedDescription);
            }
            defer {
                
                //Last minute clean up...
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
            LoaderHelper.DismissLoaderWithDefault();
        };
        
    }
    
    func searchResultsForVehiclesQuery(query: String, actionResults:@escaping(VehiclesDto?) -> Void){
        LoaderHelper.ShowLoaderWithMessage("Searching for Vehicles under \"\(query)\"...");
        
        let consumer = RestConsumerHelper.Get_DefaultRestConsumer();
        //Invoke a service client on each request, because these will be disposed by ARC
        consumer.resource("/vehicles").withParam("search", "\(query)").loadIfNeeded()?.onSuccess { entity in
            
            //Convert these data bytes into a json string and map into the json model for processing
            do {
                
                let rawJson = String(bytes: try JSONSerialization.data(withJSONObject: entity.jsonDict, options: []), encoding: String.Encoding.utf8);
                
                actionResults(try? JSONParserSwift.parse(string: rawJson!));
            } catch {
                print(error.localizedDescription);
            }
            defer {
                //Last minute clean up...
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
        .onFailure { (result) -> Void in
            SnackbarHelper.showSnackBarWithMessage(message: "Failed to connect to the SWAPI Server");
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
    
    
    //Insert Dashboard Item
    func insertItemInDashboard(film: FilmsResultDto){
        self._database.insertFilm(dto: film);
    }
    
    func getResultsForFilmsFromDashboard(actionResults:@escaping(Array<FilmsResultDto>) -> Void){
        
        LoaderHelper.ShowLoaderWithMessage("Preparing for Search");
        
        DispatchQueue.global(qos: .background).async {
            let filmAssets = self._database.getFilmsFromDb();
            
            DispatchQueue.main.async {
                if(filmAssets != nil){
                    actionResults(filmAssets!);
                    SnackbarHelper.showSnackBarWithMessage(message: "Fetch request recovered \(filmAssets!.count) films from the dashboard");
                }
                else {
                    //Could not find any results
                    
                    SnackbarHelper.showSnackBarWithMessage(message: "Could not load any films. Please begin search, and add an item to the dashboard");
                }
                
                LoaderHelper.DismissLoaderWithDefault();
            }
        }
    }
}
