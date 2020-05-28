//
//  CitySearchViewController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import CoreLocation;
import CoreGraphics;
import SVProgressHUD;
import Material;
import Motion;
import NavigationDropdownMenu
import Toast_Swift;
import SwiftTimer;
import Siesta;
import DropDown;

class CitySearchViewController : UIViewController, UISearchBarDelegate {
    
    @IBOutlet var _barButtonMngr: UINavigationItem!
    @IBOutlet var _SearchForCity: UISearchBar!
    @IBOutlet var _CustomNavigationBar: UINavigationBar!
    @IBOutlet var _SearchResultsTable: UITableView!
    
    var _dropDownView : DropDown?;
    var DataSource :  SearchWeatherSource?;
    
    //handlers
    var completionSearchHandler: ()-> Void = {
            () -> Void in
        }
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
        SetupSearchComponent();
        
        OnStartup();
    }
    
    ///Anything that needs to run the first time that the view controller starts up will run here
    private func OnStartup(){
        self._SearchForCity.becomeFirstResponder();
    }
    
    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
    //    public override func viewWillAppear(_ animated: Bool) {
    //
    //        self.loadViewIfNeeded();
    //
    //    }
    
    
    fileprivate func SetupSearchComponent(){
        self._SearchForCity.delegate = self;
    }
    
    
    fileprivate func SetupDataSource()
    {
        self.DataSource = SearchWeatherSource.init(_completionHandler:{ (item: Int) -> Void in
            self.ManageItemSelection(item, isRemoving: false);
        }, _deletionHandler:{ (item: Int) -> Void in
            
            //invoke the view model to remove this item from the database before
            self.ManageItemSelection(item, isRemoving: true);
        }, _previewHandler:{ (item: Int) -> Void in
            
            //Show a popup with some extra details on the city
            self.completionSearchHandler();
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
    
    fileprivate func ManageItemSelection(_ item: Int, isRemoving: Bool){
        //On Selection, the view controller will invoke the view model
        //THe view model will then add the item into the db, and on successful operation, without throwing any errors or exceptions, it will notify the controller to force update its search items
        
        
        //Invoke the view model to add the item to the database
        //then dismiss the controller,
        //the next time the dashboard reloads, it will automatically invoke the database for an update, and update it's records from the server
        
        //Invoke the Grand Central Dispatch to manage this callbacks on a different core
        self.dismiss(animated: true, completion: {() -> Void in
            
            
        });
    }
    
    //Search Bar Results
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        //Replace the built in data source with the custom one
        CitySearchViewModel.GetCityResults_ByQuery(self, searchBar.text!);
    }
    
    func PartialSearchResults(_ item: inout WeatherMaster){
        
        //Get the results of one city, then make another request to get more cities based on a box generator of lat/long coordinates
        CitySearchViewModel.GetCityResults_ByCities(self, self._SearchForCity.text!, CLLocationCoordinate2D.init(latitude: item.coord.lat, longitude: item.coord.lon));
    }
    
    func FullSearchResults(_ item: inout WeatherMasters){
        self.DataSource?.SearchResults = item.list;
        self._SearchResultsTable!.dataSource = self.DataSource;
        self._SearchResultsTable!.delegate = self.DataSource;
        self._SearchResultsTable!.reloadData();
        self._SearchResultsTable!.refreshControl?.endRefreshing();
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        CitySearchViewModel.GetCityResults_ByQuery(self, self._SearchForCity.text!);
    }
}
