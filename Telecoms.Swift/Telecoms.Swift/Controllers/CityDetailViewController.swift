//
//  CityDetailViewController.swift
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

class CityDetailViewController : BaseViewController {
    var CityID : Int?;
    
    var _dropDownView : DropDown?;
    var _masterScroll : UIScrollView?
    var DataSource :  DashboardWeatherSource?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        RefreshItems();
    }
    
    fileprivate func SetupDataSource() {
        self.DataSource = DashboardWeatherSource.init();
        self.tableView!.dataSource = self.DataSource;
        self.tableView!.delegate = self.DataSource;
    }
    
    fileprivate func SetupOtherUIComponents(){
        let masterRefreshMngr = UIRefreshControl.init();
        masterRefreshMngr.addTarget(self, action: #selector(RefreshItems), for: UIControl.Event.valueChanged);
        
        self.tableView.refreshControl = masterRefreshMngr;
    }
    
    fileprivate func SetupNavigationBar(){
        
        //self.navigationItem.titleView = _menuView!;
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(OpenMenuDrawer)), animated: true);
        
        _dropDownView = NavigationHelper.DrawDropDownItems();
        _dropDownView!.anchorView = self.navigationItem.rightBarButtonItem // UIView or UIBarButtonItem
        _dropDownView!.selectionAction = { [unowned self] (index: Int, item: String) in
            
            switch index {
            case 0: //Recent Searches...
                
                break;
            case 1: //Add a new location...
                self.NavigateToModalPage(NavigationHelper.GetCitySearchController(), action: nil);
                break;
            case 2: //Maps for all added locations
                
                break;
            case 3: //Application Setting
                
                break;
            default:
                print("Any other options go here...");
            }
            
        }
        
        // self.view!.addSubview(navigationBar!);
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        
        //Hide the dropdown everytime the user navigates to another page
        _dropDownView!.hide()
    }
    
    @objc fileprivate func OpenMenuDrawer(){
        _dropDownView!.show()
    }
    
    
    // MARK: Processors from the ViewModel -- Passing Data to the Data Source
    @objc func RefreshItems() {
        LoaderHelper.ShowLoaderWithMessage("Synchronising");
    }
}
