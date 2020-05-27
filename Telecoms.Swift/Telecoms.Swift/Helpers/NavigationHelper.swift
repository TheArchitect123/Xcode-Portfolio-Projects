//
//  NavigationHelper.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Material;
import UIKit;
import CoreGraphics;
import NavigationDropdownMenu;
import DropDown;

class NavigationHelper {
    
    public static func GetActiveViewController() -> UIViewController? {
        return UIApplication.shared.findTopViewController();
    }
    
    internal static func DrawNavigationBarWithBack() -> CustomNavigationBar {
        let navBar = CustomNavigationBar.init(frame: CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: 70));
        navBar.backgroundColor = ColorHelper.NavBar_DarkThemeBackground();
        navBar.layer.borderWidth = 0.5;
        navBar.layer.borderColor = UIColor.black.cgColor;
        
        //Components
        navBar.LeftBarButton.setImage(UIImage.init(named: "BackIcon"), for: UIControl.State.normal);
        navBar.LeftBarButton.setImage(UIImage.init(named: "BackIcon"), for: UIControl.State.highlighted);
        navBar.LeftBarButton.setImage(UIImage.init(named: "BackIcon"), for: UIControl.State.selected);
        
        navBar.LeftBarButton.imageView?.contentMode = .scaleAspectFit;
        
        return navBar;
    }
    
    internal static func DrawNavigationWithMenu() -> CustomNavigationBar {
        let navBar = CustomNavigationBar.init(frame: CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: 70));
        navBar.backgroundColor = ColorHelper.NavBar_DarkThemeBackground();
        navBar.layer.borderWidth = 0.5;
        navBar.layer.borderColor = UIColor.black.cgColor;
        navBar.roundCorners([.bottomRight, .bottomLeft], radius: 10);
        
        //Components
        navBar.LeftBarButton.setImage(UIImage.init(named: "ArrowDown"), for: UIControl.State.normal);
        navBar.LeftBarButton.setImage(UIImage.init(named: "ArrowDown"), for: UIControl.State.highlighted);
        navBar.LeftBarButton.setImage(UIImage.init(named: "ArrowDown"), for: UIControl.State.selected);
        
        navBar.LeftBarButton.imageView?.contentMode = .scaleAspectFit;
        return navBar;
    }
    
    internal static func DrawMenuDropDown() -> NavigationDropdownMenu {
        
        let items = ["Maps", "Recent Searches", "Settings", "Search for City..."]
        
        let controller = UIApplication.shared.findTopViewController();
        let _menuView = NavigationDropdownMenu.init(navigationController: controller?.navigationController, containerView: (controller?.view)!, title: Title.title("\(AppInformation.ApplicationName)"), items: items)
        
        // _menuView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 70)
        // _menuView.backgroundColor = ColorHelper.NavBar_DarkThemeBackground();
        _menuView.cellBackgroundColor = ColorHelper.NavBar_DarkThemeBackground();
        
        _menuView.shouldChangeTitleText = false;
        _menuView.cellTextLabelColor = UIColor.black;
        _menuView.menuTitleColor = UIColor.black;
        _menuView.cellTextLabelFont = UIFont.init(name: "Roboto-Light", size: 18.0)
        _menuView.navigationBarTitleFont = UIFont.init(name: "Roboto-Light", size: 20.0);
        
        //Components
        //        let arrowOperator = UIImageView.init(frame: CGRect(x: 20, y: (_menuView.bounds.height / 2.0 - 20), width: 40, height: 40));
        //        arrowOperator.image = UIImage.init(named: "ArrowDown");
        //        arrowOperator.isUserInteractionEnabled = false;
        
        // _menuView.addSubview(arrowOperator);
        return _menuView;
    }
    
    internal static func DrawDropDownItems() -> DropDown {
        
        let customisedDropDown = DropDown()
        customisedDropDown.dataSource = ["Recent Searches...", "Add a new location...", "Maps", "Settings"];
        customisedDropDown.textColor = UIColor.black;
        customisedDropDown.cornerRadius = 5.0;
        
        return customisedDropDown;
    }
    
    //Generate Controllers
    static func GetCitySearchController() -> CitySearchViewController{
       return (UIStoryboard.init(name: "Main", bundle: nil)).instantiateViewController(withIdentifier: "CitySearchViewController") as! CitySearchViewController
    }
    
    static func GetCityDetailViewController() -> CityDetailViewController{
       return (UIStoryboard.init(name: "Main", bundle: nil)).instantiateViewController(withIdentifier: "CityDetailViewController") as! CityDetailViewController
    }
}
