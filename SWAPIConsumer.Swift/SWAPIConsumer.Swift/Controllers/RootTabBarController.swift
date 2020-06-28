//
//  RootTabBarController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 11/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

//Material Components
import MaterialComponents.MaterialBottomAppBar;
import MaterialComponents.MDCActionSheetAction;
import MaterialComponents.MDCShadowElevations;
import MaterialComponents.MaterialNavigationDrawer;

class RootTabBarController : UITabBarController, MDCBottomNavigationBarDelegate {
    
    //Controllers
    var _dashboardPage : DashboardController?;
    var _settingsPage : SettingsController?;
    
    //Controls
    var _bottomTabBar : MDCBottomNavigationBar?;
    
    var _searchFloatBtn : MDCFloatingButton?;
    
    override func viewDidLoad() {
        configureTabBar();
        setupNavigationBarComponents();
        configureTabBarControllers();
        welcomeLogic();
        setupOtherUIComponents();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self._dashboardPage!.deletionHandler = {() -> Void in 
            self.refreshItems();
        };
        
        refreshItems();
    }
    
    func refreshItems(){
        self._dashboardPage!.updateTableViewWithFilms();
    }
    
    override func viewDidLayoutSubviews() {
        resizeSearchBtn();
    }
    
    func resizeSearchBtn(){
        self._searchFloatBtn!.frame = CGRect.init(x: self.view.ScreenWidth() - 100.0, y: self.view.ScreenHeight() - 160.0, width: 80.0, height: 80.0);
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(self._searchFloatBtn != nil && self._bottomTabBar != nil){
            self._searchFloatBtn!.frame = CGRect.init(x: size.width - 100.0, y: size.height - 80.0, width: 80.0, height: 80.0);
            
            self._bottomTabBar = MDCBottomNavigationBar.init(frame: CGRect(x: 0, y: size.height - 60.0, width: size.width, height: 60.0));
        }
    }
    
    func setupOtherUIComponents() {
        
        //Refresh Floating Button
        self._searchFloatBtn = MDCFloatingButton.init(frame: CGRect.init(x: self.view.ScreenWidth() - 100.0, y: self.view.ScreenHeight() - 160.0, width: 80.0, height: 80.0));
        self._searchFloatBtn!.backgroundColor = ColorHelper.DarkThemeBackground();
        self._searchFloatBtn!.setImage(UIImage.init(named: "Search"), for: UIControl.State.normal);
        self._searchFloatBtn!.addTarget(self, action: #selector(openSearchDrawer), for: UIControl.Event.touchDown);
        
      //  self.view.addSubview(self._searchFloatBtn!);
    }
    
    
    func welcomeLogic(){
        SnackbarHelper.showSnackBarWithMessage(message: "Welcome to SWAPIConsumer by Dan Gerchcovich");
    }
    
    func configureTabBar(){
        self.tabBar.isHidden = true;
        self._bottomTabBar = MDCBottomNavigationBar.init(frame: CGRect(x: 0, y: self.view.ScreenHeight() - 60.0, width: self.view.ScreenWidth(), height: 60.0));
        self._bottomTabBar?.backgroundBlurEffectStyle = .prominent;
        
        self._bottomTabBar?.delegate = self;
        
        //If not MAC OS -- Remove the Tab Bar
  //  self.view.addSubview(self._bottomTabBar!);
    }
    
    func configureTabBarControllers(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        _dashboardPage = storyboard.instantiateViewController(withIdentifier: "DashboardController") as! DashboardController;
        _dashboardPage?.tabBarItem.title = "Dashboard";
        _dashboardPage?.tabBarItem.image = UIImage(named: "DashboardTab");
        _dashboardPage?.tabBarItem.tag = 0;
        
        _settingsPage = storyboard.instantiateViewController(withIdentifier: "SettingsController") as! SettingsController;
        _settingsPage?.tabBarItem.title = "Settings";
        _settingsPage?.tabBarItem.image = UIImage(named: "SettingsTab");
        _settingsPage?.tabBarItem.tag = 1;
        
        self.setViewControllers([_dashboardPage!, _settingsPage!], animated: false);
        self._bottomTabBar?.items = [_dashboardPage!.tabBarItem, _settingsPage!.tabBarItem];
        self._bottomTabBar?.selectedItem = _dashboardPage?.tabBarItem;
    }
    
    //Tab Bar Selection
    func bottomNavigationBar(_ bottomNavigationBar: MDCBottomNavigationBar, didSelect item: UITabBarItem) {
        self.selectedViewController = self.viewControllers![item.tag];
        if(item.tag == 0){
            //Run some other logic here
        }
    }
    
    func setupNavigationBarComponents(){
        //Any Business logic for the navigation bar needs to be captured here
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(openSearchDrawer)), animated: false);
    }
    
    @objc func openMenuDrawer(){
        //Open the menu drawer for extra functions
        
    }
    
    @objc func openSearchDrawer(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil);
        let searchController = storyboard.instantiateViewController(withIdentifier: "SearchMoviesController") as! SearchMoviesController;
        searchController.completionHandler = {() -> Void in
            self.refreshItems();
        };
        searchController.modalPresentationStyle = .fullScreen;
        
        
        let searchActions = NSMutableArray(capacity: 5);
        //Search by People
        searchActions.add(MDCActionSheetAction.init(title: "People", image: UIImage.init(named: "People"), handler: { (e) in
            //Open up the Search Controller, and pass in the category, via the its search functions
            
            searchController.Category = .people;
            self.present(searchController, animated: true, completion: nil);
        }));
        
        //Search by Planets
        searchActions.add(MDCActionSheetAction.init(title: "Planets", image: UIImage.init(named: "Planets"), handler: { (e) in
            //Open up the Search Controller, and pass in the category, via the its search functions
            searchController.Category = .planets;
            self.present(searchController, animated: true, completion: nil);
        }));
        
        
        //Search by Films
        searchActions.add(MDCActionSheetAction.init(title: "Films", image: UIImage.init(named: "Films"), handler: { (e) in
            //Open up the Search Controller, and pass in the category, via the its search functions
            searchController.Category = .films;
            self.present(searchController, animated: true, completion: nil);
        }));
        
        
        //Search by Species
        searchActions.add(MDCActionSheetAction.init(title: "Species", image: UIImage.init(named: "Species"), handler: { (e) in
            //Open up the Search Controller, and pass in the category, via the its search functions
            searchController.Category = .species;
            self.present(searchController, animated: true, completion: nil);
        }));
        
        
        //Search by Vehicles
        searchActions.add(MDCActionSheetAction.init(title: "Vehicles", image: UIImage.init(named: "Vehicles"), handler: { (e) in
            //Open up the Search Controller, and pass in the category, via the its search functions
            searchController.Category = .vehicles;
            self.present(searchController, animated: true, completion: nil);
        }));
        
        
        //Search by Starships
        searchActions.add(MDCActionSheetAction.init(title: "Starships", image: UIImage.init(named: "StarShips"), handler: { (e) in
            //Open up the Search Controller, and pass in the category, via the its search functions
            searchController.Category = .starships;
            self.present(searchController, animated: true, completion: nil);
        }));
        
        DialogueHelper.showActionSheetWithSimpleMessage(message: "Choose a category of items to search for", actionBtns: searchActions as! Array<MDCActionSheetAction>);
    }
    
    //Refresh
    @objc func RefreshItemsForQuery(query : String){
        
        //Invoke the star wars api, to retreive details
    }
}
