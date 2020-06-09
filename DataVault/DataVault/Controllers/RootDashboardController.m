//
//  RootDashboardController.m
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "RootDashboardController.h"
#import "DashboardCardView.h"
#import "Enums.h"
#import "AppInformation.h"

//Data Sources
#import "DashboardDataSource.h"

//Helpers
#import "StringHelpers.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"
#import "ScreenHelper.h"
#import "ColorHelper.h"
#import "MimeHelper.h"
#import "DateHelpers.h"

//Material Design
#import <PDSnackbar/PDSnackbar.h>
#import <MaterialTextField/MaterialTextField.h>
#import <MaterialButtons.h>
#import <MaterialComponents/MaterialCards.h>
#import <MaterialComponents/MaterialNavigationDrawer.h>
#import <MaterialComponents/MaterialBottomAppBar.h>

@implementation RootDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self ConfigureDashboard];
    [self configureRefreshComponent];
    [self checkAuthStatus];
    [self SetupOtherUIComponents];
    [self refreshItems];
}


-(void) checkAuthStatus{
    
    //If the user is not signed in
    //    if([NSUserDefaults valueForKey:@"auth_status"]){
    //        [SnackBarHelper showSnackBarWithMessage:@"Welcome to SafetyBox!"];
    //    }
    //    else {
    //        //Retrieve the account information fromt he Core Data Accounts Entity
    //        NSString* username = [NSUserDefaults valueForKey:@"auth_identity"];
    //        if([username isEqualToString:@""]){
    //            [SnackBarHelper showSnackBarWithMessage:@"Failed to retrieve your account information!"];
    //        }
    //        else {
    //            [SnackBarHelper showSnackBarWithMessage: [NSString stringWithFormat:@"%@ %@", @"Welcome back ", @"ANONYMOUS"]];;
    //        }
    //    }
    
    // [SnackBarHelper showSnackBarWithMessage:@"Welcome to SafetyBox!"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self refreshItems];
}

-(void)SetupOtherUIComponents {
    
    //Bottom Bar
    
}

-(void) refreshItems{
    [self.tableView.refreshControl beginRefreshing];
    
    [self.DataSource._dataArray removeAllObjects];
    [self.tableView reloadData];
    
    [SnackBarHelper showSnackBarWithMessage:@"Synchronising database with device"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //Run in background thread while a loader is showing
        
        uint notesCount = [self.DataSource._dbHelper getNotesCount];
        uint documentsCount = [self.DataSource._dbHelper getDocumentCount];
        uint pdfsCount = [self.DataSource._dbHelper getPDFsCount];
        uint photosCount = [self.DataSource._dbHelper getPhotosCount];
        uint videosCount = [self.DataSource._dbHelper getVideosCount];
        //[SnackBarHelper showSnackBarWithMessage:[@"Retrieved photos"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.DataSource._dataArray addObject:[NSString stringWithFormat:@"%u", notesCount]];
            [self.DataSource._dataArray addObject:[NSString stringWithFormat:@"%u", documentsCount]];
            [self.DataSource._dataArray addObject:[NSString stringWithFormat:@"%u", pdfsCount]];
            [self.DataSource._dataArray addObject:[NSString stringWithFormat:@"%u", photosCount]];
            [self.DataSource._dataArray addObject:[NSString stringWithFormat:@"%u", videosCount]];
            [self.DataSource._dataArray addObject:@"0"];
            [self.DataSource._dataArray addObject:@"0"];
            [self.DataSource._dataArray addObject:@"0"];
            
            [self.tableView reloadData];
            [self.tableView.refreshControl endRefreshing];
        });
    });
}

#pragma mark - Load the DataSource (Dashboard DataSource)
-(void)ConfigureDashboard {
    self.DataSource = [[DashboardDataSource alloc] init];
    self.DataSource._parentController = self.navigationController.viewControllers[0];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(60.0f, 0, 0.0f, 0)];
    self.tableView.dataSource = self.DataSource;
    self.tableView.delegate = self.DataSource;
    self.tableView.rowHeight = 100.0f;
    self.tableView.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
}

-(void) configureRefreshComponent{
    UIRefreshControl* refreshDashboard = [[UIRefreshControl alloc] init];
    [refreshDashboard addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshDashboard;
}

@end
