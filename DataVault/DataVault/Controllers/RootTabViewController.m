//
//  RootTabViewController.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "RootTabViewController.h"
#import "RootDashboardController.h"
#import "ScreenHelper.h"

#import <UIKit/UIKit.h>

//Material Components
#import <MaterialComponents/MaterialBottomAppBar.h>

@implementation RootTabViewController

-(void) viewDidLoad{
    //Replace the Bottom Tab Bar with the material Bar
    
    [self configureControllers];
   // [self configureAppBarItems];
}

-(void) configureAppBarItems{
    self._bottomNavBar = [[MDCBottomNavigationBar alloc] init];
    
//    [self._bottomNavBar setItems:[[UITabBarItem alloc] initWithTitle:@"Test" image:@"Dashboard_PhotosVideosIcon" tag:0]];
    
    
    //[self.tabBar setHidden:true];
    //[self._bottomNavBar setSelectedItem:];
    //[self.view addSubview:self._bottomNavBar];

    [self setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Dashboard" image:@"Dashboard_PhotosVideosIcon" tag:0]];
}

-(void) configureControllers{
    [self.tabBar setHidden:true];
    self._bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 70.0f, [ScreenHelper GetScreenWidth], 70.0f)];
    
    [self.view addSubview:self._bottomNavBar];
    
    UIStoryboard* storyMngr = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    
    RootDashboardController* root = [storyMngr instantiateViewControllerWithIdentifier:@"RootDashboardController"];
    root.tabBarItem.title = @"Dashboard";
    root.tabBarItem.image = [UIImage imageNamed:@"Dashboard_PhotosVideosIcon"];
    
    RootDashboardController* root1 = [storyMngr instantiateViewControllerWithIdentifier:@"RootDashboardController"];
    root1.tabBarItem.title = @"Test 1";
    root1.tabBarItem.image = [UIImage imageNamed:@"Dashboard_PhotosVideosIcon"];
    
    RootDashboardController* root2 = [storyMngr instantiateViewControllerWithIdentifier:@"RootDashboardController"];
    root2.tabBarItem.title = @"Test 2";
    root2.tabBarItem.image = [UIImage imageNamed:@"Dashboard_PhotosVideosIcon"];
    
    
    self.viewControllers = [[NSArray alloc] initWithObjects:root,root1,root2, nil];
    self._bottomNavBar.items = [[NSArray alloc] initWithObjects:[[UITabBarItem alloc] initWithTitle:@"Dashboard" image:@"Dashboard_PhotosVideosIcon" tag:0], nil];
}

@end
