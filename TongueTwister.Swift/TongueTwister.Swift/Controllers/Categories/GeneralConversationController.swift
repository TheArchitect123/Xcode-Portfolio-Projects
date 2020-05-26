//
//  GeneralConversationController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Motion;
import Material;
import SVProgressHUD;
import Siesta;
import Unbox;
import Toast_Swift;
import Alamofire;

internal class GeneralConversationController : BaseTableViewController, ResourceObserver {
    
    let CustomSource : PhrasesDataSource = PhrasesDataSource.init(PhraseCategories.GeneralConversation);
    
    fileprivate func LoadAllItemsForCategory() {
        //Reads the database for items, added from the PostGres Backend, that will be responsible for binding the items into the collection
        
        //Once the data has been loaded it will be passed into the data source object
        SVProgressHUD.show(withStatus: "Loading Phrases");
        
        //Invoke the grand central dispatch here for processing
        self.CustomTableView!.dataSource = CustomSource;
        self.CustomTableView?.delegate = CustomSource;
        self.CustomTableView!.reloadData()
    }
    
    func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        
        
    }
    
    internal override func RefreshItems() {
        super.RefreshItems();
        
        self.view.makeToast("Refreshing all General Conversation phrases. Please wait a few seconds...", duration: 3.0, position: .bottom)
        
        RestConsumerHelper.Get_DefaultRestConsumer()
            .resource("/get_phrases").withParam("category", "\(PhraseCategories.GeneralConversation.rawValue)").loadIfNeeded()?.onSuccess { entity in
                
            guard let data = entity.content as? Data else {
                print("Huh, got mystery response:", entity.content)
                
                self.view.hideAllToasts();
                self.view.makeToast("Retrieved \(59) phrases from the data center", duration: 3.0, position: .bottom);
                
                return;
            }
                
                //Convert these data bytes into a json string and map into the json model for processing
                
        }.onProgress{(result) -> Void in
                
                LoaderHelper.ShowLoaderWithProgress(Float(result.magnitude));
                }.onFailure { (result) -> Void in
                
                self.view.hideAllToasts();
                self.view.makeToast("Failed to retrieve items from the server", duration: 3.0, position: .bottom)
                
                self.CustomTableView?.refreshControl?.endRefreshing();
                LoaderHelper.DismissLoaderWithDefault();
                
        };
        
        
        //        RestConsumerHelper.Get_DefaultRestConsumer_ForTesting().resource("/get").addObserver(owner: self) {
        //                       [weak self] resource, event in
        //
        //                       do {
        //                           let user: PhrasesInfo = try unbox(dictionary: resource.jsonDict);
        //                       }
        //                       catch{
        //                           print(error.localizedDescription);
        //                       }
        //                       print("Url: \n \(resource.url.absoluteString)");
        //                       print(resource.entityForTypedContentAccessors?.jsonArray);
        //
        //                       self?.CustomTableView?.refreshControl?.endRefreshing();
        //                       LoaderHelper.DismissLoaderWithDefault();
        //
        //               }.loadIfNeeded()?.onSuccess { entity in
        //                   guard let data = entity.content as? Data else {
        //                       print("Huh, got mystery response:", entity.content)
        //                       return
        //                   }}.onFailure { (result) -> Void in
        //
        //                       print("Status Code: \n \(result.httpStatusCode)");
        //                       print("Reason For Failure: \n \(result.cause)");
        //                       print("Localised Reason: \n \(result.localizedDescription)");
        //                       print("Reason Forailure: \n \(result.text)");
        //                       };
        //
        //
        
        
        //Any Custom business logic relating to this specific category -- such as retrieving items from the server, will be written here.
        
        //Use dependency injection, to allow the view model on this controller to manage the business logic here
        
        // self.CustomTableView?.refreshControl?.endRefreshing();
        // SVProgressHUD.dismiss();
    }
}

//extension Bool: Siesta.JSONConvertible { }

