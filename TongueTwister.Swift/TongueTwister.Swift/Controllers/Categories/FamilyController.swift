//
//  FamilyController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Material;
import Motion;
import SVProgressHUD;
import JSONParserSwift;
import Siesta;

internal class FamilyController : BaseTableViewController {
    
     let CustomSource : PhrasesDataSource = PhrasesDataSource.init(PhraseCategories.Emergency);
       
       fileprivate func LoadAllItemsForCategory() {
           //Reads the database for items, added from the PostGres Backend, that will be responsible for binding the items into the collection
           
           //Once the data has been loaded it will be passed into the data source object
           SVProgressHUD.show(withStatus: "Loading Phrases");
           
           //Invoke the grand central dispatch here for processing
           self.CustomTableView!.dataSource = CustomSource;
           self.CustomTableView?.delegate = CustomSource;
           self.CustomTableView!.reloadData()
       }

       public override func viewWillAppear(_ animated: Bool) {
           RefreshItems();
       }
       
       internal override func RefreshItems() {
           super.RefreshItems();
           
           self.view.makeToast("Refreshing all \(FriendlyNames.GetCategoryForNames(PhraseCategories.Family)) phrases. Please wait a few seconds...", duration: 3.0, position: .bottom)
           
           RestConsumerHelper.Get_DefaultRestConsumer()
               .resource("/get_phrases").withParam("category", "\(PhraseCategories.Family.rawValue)").loadIfNeeded()?.onSuccess { entity in
                   
                   //Convert these data bytes into a json string and map into the json model for processing
                   
                   do {
                       self.CustomSource.Items = try JSONParserSwift.parse(string: entity.content as! String) as Array<PhrasesInfo> ;
                       
                       ToasterHelper.OpenSimpleToast(self, "Successfully retrieved \(self.CustomSource.Items.count) phrases from the server");
                       
                       self.CustomTableView!.dataSource = self.CustomSource;
                       self.CustomTableView!.delegate = self.CustomSource;
                       self.CustomTableView!.reloadData();
                     // Use base response object here
                   } catch {
                     print(error)
                   }
                   
                   self.CustomTableView?.refreshControl?.endRefreshing();
                   LoaderHelper.DismissLoaderWithDefault();
           }
           .onFailure { (result) -> Void in
               
               ToasterHelper.OpenSimpleToast(self, "Failed to retrieve items from the server");
               
               self.CustomTableView?.refreshControl?.endRefreshing();
               LoaderHelper.DismissLoaderWithDefault();
               
           };
      }
}
