//
//  TechnologyController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Motion;

internal class TechnologyController : BaseTableViewController {
    
    
      let CustomSource : PhrasesDataSource = PhrasesDataSource.init(PhraseCategories.Technology);
     
     public override func viewDidLoad() {
         //Build up the UI here
         super.viewDidLoad();
         //
         self.CustomTableView!.dataSource = CustomSource;
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
