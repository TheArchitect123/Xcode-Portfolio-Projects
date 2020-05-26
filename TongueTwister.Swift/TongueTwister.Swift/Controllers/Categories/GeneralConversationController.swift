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

internal class GeneralConversationController : BaseTableViewController {
    
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
    
    internal override func RefreshItems() {
        super.RefreshItems();
        
        //Any Custom business logic relating to this specific category -- such as retrieving items from the server, will be written here.
        
        //Use dependency injection, to allow the view model on this controller to manage the business logic here
        
        // self.CustomTableView?.refreshControl?.endRefreshing();
        // SVProgressHUD.dismiss();
    }
}
