//
//  RootTabViewController.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>

//Tabs
#import "RootDashboardController.h"
#import "RootSearchViewController.h"
#import "RootSettingsViewController.h"

//Material
#import <MaterialComponents/MaterialBottomAppBar.h>
#import <MaterialComponents/MDCBottomNavigationBarDelegate.h>

#import <MaterialComponents/MDCFloatingButton.h>
#import <MaterialComponents/MDCFloatingButton+MaterialTheming.h>

@interface RootTabViewController : UITabBarController<MDCBottomNavigationBarDelegate>

@property(nonatomic, readwrite, strong) MDCBottomNavigationBar* _bottomNavBar;
@property(nonatomic, readwrite, strong) MDCFloatingButton* _refreshFloatBtn;

@property(nonatomic, readwrite, strong) RootDashboardController* _dashboardPage;
@property(nonatomic, readwrite, strong) RootSearchViewController* _searchPage;
@property(nonatomic, readwrite, strong) RootSettingsViewController* _settingsPage;

@end
