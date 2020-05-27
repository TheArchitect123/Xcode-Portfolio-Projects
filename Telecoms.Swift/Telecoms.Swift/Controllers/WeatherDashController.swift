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

class WeatherDashController : BaseViewController {
    //var navigationBar : CustomNavigationBar?;
    var _menuView : NavigationDropdownMenu?;
    var _masterScroll : UIScrollView?
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        ToasterHelper.OpenSimpleToast(self, "Welcome to \(AppInformation.ApplicationName)! Created by Dan Gerchcovich");
        SetupNavigationBar();
    }
    
    fileprivate func SetupNavigationBar(){
        //        self.navigationController!.setNavigationBarHidden(true, animated: false);
        
        //        navigationBar = NavigationBarHelper.DrawNavigationWithMenu();
        //        navigationBar!.LeftBarButton.addTarget(self, action: #selector(OpenMenuDrawer), for: UIControl.Event.touchDown);
        
        _menuView = NavigationHelper.DrawMenuDropDown();
        _menuView!.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            
            print("Navigate to any of the specific settings required");
        }
        
        self.navigationItem.titleView = _menuView!;
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(OpenMenuDrawer)), animated: true);
        
        // self.view!.addSubview(navigationBar!);
    }
    
    @objc fileprivate func OpenMenuDrawer(){
        _menuView?.toggle();
    }
    
    @objc internal override func RefreshItems() {
        RestConsumerHelper.Get_DefaultRestConsumer()
            .resource("/get_phrases").withParam("category", "").loadIfNeeded()?.onSuccess { entity in
                
                
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
