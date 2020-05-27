//
//  WeatherDashboardController.swift
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

class WeatherDashController : BaseViewController {
    var _dropDownView : DropDown?;
    var _masterScroll : UIScrollView?
    var DataSource :  DashboardWeatherSource?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        ToasterHelper.OpenSimpleToast(self, "Welcome to \(AppInformation.ApplicationName)! Created by Dan Gerchcovich");
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
        RefreshItems();
    }
    
    fileprivate func SetupDataSource(){
        self.DataSource = DashboardWeatherSource.init();
        self.tableView!.dataSource = self.DataSource;
        self.tableView!.delegate = self.DataSource;
        self.tableView!.reloadData();
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
    
    @objc internal override func RefreshItems() {
        super.RefreshItems();
        
        RestConsumerHelper.Get_DefaultRestConsumer()
            .resource("/get_phrases").withParam("category", "").loadIfNeeded()?.onSuccess { entity in
                
                self.tableView!.dataSource = self.DataSource;
                self.tableView!.delegate = self.DataSource;
                self.tableView!.reloadData();
                
                self.tableView?.refreshControl?.endRefreshing();
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
            
            self.tableView?.refreshControl?.endRefreshing();
            LoaderHelper.DismissLoaderWithDefault();
        };
    }
}
