//
//  RootDashboardController.h
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashboardCardView.h"
#import "BaseControllers/BaseViewController.h"
#import <MaterialComponents/MaterialNavigationDrawer.h>
#import <MaterialComponents/MaterialBottomNavigation.h>

//Internal
#import "DashboardDataSource.h"

@interface RootDashboardController : BaseViewController

@property(nonatomic, readwrite, strong) DashboardDataSource* DataSource;
-(void) refreshItems;

@end
