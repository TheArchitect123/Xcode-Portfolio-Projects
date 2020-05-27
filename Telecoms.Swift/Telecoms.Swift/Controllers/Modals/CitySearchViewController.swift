//
//  CitySearchViewController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import CoreGraphics;
import SVProgressHUD;
import Material;
import Motion;
import NavigationDropdownMenu
import Toast_Swift;
import SwiftTimer;
import Siesta;
import DropDown;

class CitySearchViewController : UIViewController {
    
    @IBOutlet var _barButtonMngr: UINavigationItem!
    @IBOutlet var _SearchForCity: UISearchBar!
    @IBOutlet var _CustomNavigationBar: UINavigationBar!
    @IBOutlet var _SearchResultsTable: UITableView!
    
    var _dropDownView : DropDown?;
    var DataSource :  SearchWeatherSource?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
        OnStartup();
    }
    
    ///Anything that needs to run the first time that the view controller starts up will run here
    private func OnStartup(){
        self._SearchForCity.becomeFirstResponder();
    }
    
    //    public override func viewWillAppear(_ animated: Bool) {
    //
    //        self.loadViewIfNeeded();
    //
    //    }
    
    fileprivate func SetupDataSource()
    {
        self.DataSource = SearchWeatherSource.init(_handler:{ (item: Int) -> Void in
            self.ManageItemSelection(item);
        });
        
        self._SearchResultsTable!.dataSource = self.DataSource;
        self._SearchResultsTable!.delegate = self.DataSource;
        self._SearchResultsTable.rowHeight = 120;
        self._SearchResultsTable!.reloadData();
    }
    
    fileprivate func SetupOtherUIComponents(){
        
    }
    
    fileprivate func SetupNavigationBar()
    {
        //self.navigationItem.titleView = _menuView!;
        _barButtonMngr.setLeftBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(CloseDialog)), animated: true);
    
        // self.view!.addSubview(navigationBar!);
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        
        //Hide the dropdown everytime the user navigates to another page
        // _dropDownView!.hide()
    }
    
    @objc fileprivate func OpenMenuDrawer(){
        
    }

    @objc fileprivate func CloseDialog(){
        self.PopModalPage();
    }
    
    fileprivate func ManageItemSelection(_ item: Int){
     //On Selection, the view controller will invoke the view model
    //THe view model will then add the item into the db, and on successful operation, without throwing any errors or exceptions, it will notify the controller to force update its search items
    }

    
    @objc internal func RefreshItems() {
        // super.RefreshItems();
        
        RestConsumerHelper.Get_DefaultRestConsumer()
            .resource("/get_phrases").withParam("category", "").loadIfNeeded()?.onSuccess { entity in
                
                self._SearchResultsTable!.dataSource = self.DataSource;
                self._SearchResultsTable!.delegate = self.DataSource;
                self._SearchResultsTable!.reloadData();
                
                self._SearchResultsTable?.refreshControl?.endRefreshing();
                LoaderHelper.DismissLoaderWithDefault();
                
                //                do {
                //                    self.CustomSource.Items = try JSONParserSwift.parse(string: entity.content as! String) as Array<PhrasesInfo> ;
                //
                //                    ToasterHelper.OpenSimpleToast(self, "Successfully retrieved \(self.CustomSource.Items.count) phrases from the server");
                //
                //                    self.CustomTableView!.dataSource = self.CustomSource;
                //                    self.CustomTableView!.delegate = self.CustomSource;
                //                    self.CustomTableView!.reloadData();
                //                  // Use base response object here
                //                } catch {
                //                  print(error)
                //                }
                //
                //                self.CustomTableView?.refreshControl?.endRefreshing();
                //                LoaderHelper.DismissLoaderWithDefault();
        }
        .onFailure { (result) -> Void in
            
            ToasterHelper.OpenSimpleToast(self, "Failed to retrieve items from the server");
            
            self._SearchResultsTable?.refreshControl?.endRefreshing();
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
}
