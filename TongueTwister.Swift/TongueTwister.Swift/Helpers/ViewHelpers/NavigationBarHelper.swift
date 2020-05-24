//
//  NavigationBarHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 24/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Material;

internal class NavigationBarHelper{
    
    internal static func DrawNavigationBarWithBack() -> NavigationBar {
        let navBar = NavigationBar.init(frame: CGRect(x: 0,y: 0, width: UIHelper.ScreenWidth, height: 70));
              navBar.apply(theme: Theme.light);
              navBar.backButtonImage = Icon.arrowBack
        
              return navBar;
    }
    
    internal static func DrawNavigationWithMenu() -> NavigationBar {
        let navBar = NavigationBar.init(frame: CGRect(x: 0,y: 0, width: UIHelper.ScreenWidth, height: 70));
        navBar.backgroundColor = ColorHelper.NavBar_DarkThemeBackground();
    
        
        //Components
        var menuIcon : IconButton = IconButton.init(frame: CGRect(x: 0,y: (navBar.frame.height / 2.0) - 15, width: 15,height: 30));
        //menuIcon.addTarget(navBar, action: #selector(menuOpened), for: UIControl.Event.touchDown)
        
        
        
        navBar.addSubview(menuIcon);
    
        return navBar;
    }

}
