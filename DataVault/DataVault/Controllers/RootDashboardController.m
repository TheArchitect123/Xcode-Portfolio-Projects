//
//  RootDashboardController.m
//  DataVault
//
//  Created by Assassin on 4/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "RootDashboardController.h"
#import <PDSnackbar/PDSnackbar.h>
#import <MaterialTextField/MaterialTextField.h>
#import <MaterialButtons.h>
#import "DashboardCardView.h"
#import "ScreenHelper.h"
#import "Enums.h"
#import "AppInformation.h"

//Material Design
#import <MaterialComponents/MaterialCards.h>
#import <MaterialComponents/MaterialNavigationDrawer.h>

@implementation RootDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self ConfigureCards];
    [self configureRefreshComponent];
}

//Passwords = 0,
//  Photos = 1,
//  Notes = 2,
//  Emails = 3,
//  Documents = 4,
//  PDFs = 5

#pragma mark - Load the
-(void)ConfigureCards {
     
    #pragma mark -- Categories
    
    //Passwords
    self._notesCard = [[DashboardCardView alloc] initWithOptions:(int)Notes frameOption:CGRectMake(15.0f, self.navigationController.navigationBar.bounds.size.height - 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
     self._passwordsCard = [[DashboardCardView alloc] initWithOptions:(int)Passwords frameOption:CGRectMake(15.0f, self._notesCard.frame.origin.y + self._notesCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self ];
    self._documentsCard = [[DashboardCardView alloc] initWithOptions:(int)Documents frameOption:CGRectMake(15.0f, self._passwordsCard.frame.origin.y + self._passwordsCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
    self._pdfsCard = [[DashboardCardView alloc] initWithOptions:(int)PDFs frameOption:CGRectMake(15.0f, self._documentsCard.frame.origin.y + self._documentsCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
    self._photosCard = [[DashboardCardView alloc] initWithOptions:(int)Photos frameOption:CGRectMake(15.0f, self._pdfsCard.frame.origin.y + self._pdfsCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
    self._emailsCard = [[DashboardCardView alloc] initWithOptions:(int)Emails frameOption:CGRectMake(15.0f, self._photosCard.frame.origin.y + self._photosCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
    self._musicCard = [[DashboardCardView alloc] initWithOptions:(int)Music frameOption:CGRectMake(15.0f, self._emailsCard.frame.origin.y + self._emailsCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
    
    //Set Content Size of the scroll view
    self._dashScrollView.contentSize = CGSizeMake([ScreenHelper GetScreenWidth], (self._musicCard.frame.origin.y + self._musicCard.bounds.size.height + 20.0f));
    
    //Add the cards to the dashboard
    [self._dashScrollView addSubview:self._notesCard];
    [self._dashScrollView addSubview:self._passwordsCard];
    [self._dashScrollView addSubview:self._documentsCard];
    [self._dashScrollView addSubview:self._pdfsCard];
    [self._dashScrollView addSubview:self._photosCard];
    [self._dashScrollView addSubview:self._emailsCard];
    [self._dashScrollView addSubview:self._musicCard];
}

-(void) configureRefreshComponent{
    UIRefreshControl* refreshDashboard = [[UIRefreshControl alloc] init];
    [refreshDashboard addTarget:self action:@selector(refreshCards) forControlEvents:UIControlEventValueChanged];
    self._dashScrollView.refreshControl = refreshDashboard;
}

-(void) refreshCards {
    //Refresh all Dashboard Components
    //Invoke the RootDashboard Helper Service, that will contain the Rest Service required for dragging items from the local device and from the server
    
    //self._notesCard._categoryItemsCount.text = @"(40) >";
}

-(void)SetupOtherUIComponents {
    
}

@end
