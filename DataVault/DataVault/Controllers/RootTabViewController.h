//
//  RootTabViewController.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>

//Material
#import <MaterialComponents/MaterialBottomAppBar.h>
#import <MaterialComponents/MDCBottomNavigationBarDelegate.h>

@interface RootTabViewController : UITabBarController<MDCBottomNavigationBarDelegate>

@property(nonatomic, readwrite, strong) MDCBottomNavigationBar* _bottomNavBar;
@end
