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
import ALRadialMenu;

class WeatherDashController : BaseViewController {
    var _dropDownView : DropDown?;
    var _masterScroll : UIScrollView?
    var DataSource :  DashboardWeatherSource?;
    var FloatButton : Button?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
        
        //TEST
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(showMenu))
//        self.FloatButton!.addGestureRecognizer(gesture)
    }
    
    @objc func showMenu(sender: UITapGestureRecognizer) {

        var buttons = [ALRadialMenuButton]()
        buttons.append(ALRadialMenuButton.init(type: UIButton.ButtonType.infoDark));
        buttons.append(ALRadialMenuButton.init(type: UIButton.ButtonType.contactAdd));
        buttons.append(ALRadialMenuButton.init(type: UIButton.ButtonType.contactAdd));
        
        
        ALRadialMenu()
            .setButtons(buttons: buttons)
            .setAnimationOrigin(animationOrigin: sender.location(in: view))
            .presentInView(view: self.view)
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
        
        FloatButton = Button.init(frame: CGRect(x: self.view.ScreenWidth() - 90.0, y: self.view.ScreenHeight() - 140.0, width: 70, height: 70));
              FloatButton!.backgroundColor = ColorHelper.DarkThemeBackground();
              FloatButton!.layer.cornerRadius = 35.0;
              FloatButton!.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.normal);
              FloatButton!.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.highlighted);
              FloatButton!.setImage(UIImage.init(named: ImageConstants._refreshIcon), for: UIControl.State.selected);
              FloatButton!.addTarget(self, action: #selector(RefreshItems), for: UIControl.Event.touchDown);
    
        self.view.addSubview(FloatButton!);
    }
    
    fileprivate func AdjustConstraintsOfFloatButton(){
        //Add layout constraints so that the floating button is always on the bottom right corner
    }
    
    fileprivate func SetupNavigationBar(){
        
        //self.navigationItem.titleView = _menuView!;
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(OpenMenuDrawer)), animated: false);
        
        self.navigationItem.setLeftBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.organize, target: self, action: #selector(OpenMenuDrawer)), animated: false);
        
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
//        _dropDownView!.show()
           
        self.NavigateToModalPage(NavigationHelper.GetCitySearchController(), action: nil);
        
    }
    
    
    // MARK: Processors from the ViewModel -- Passing Data to the Data Source
    internal func ReturnedCities(_ items: inout [WeatherMaster]){
        
        self.DataSource?.Cities = items;
        self.tableView!.dataSource = self.DataSource;
        self.tableView!.delegate = self.DataSource;
        self.tableView!.reloadData();
        self.tableView!.refreshControl?.endRefreshing();
    }
    
    internal func ResetCitiesForEmptyItems(){
        
        self.DataSource?.Cities = nil;
        self.tableView!.dataSource = self.DataSource;
        self.tableView!.delegate = self.DataSource;
        self.tableView!.reloadData();
        self.tableView!.refreshControl?.endRefreshing();
    }
    
    @objc func RefreshItems() {
        WeatherDashViewModel.GetCityResults_ByCities(self, "4163971,2147714,2174003");
    }
}
