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

//Helpers
#import "StringHelpers.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"
#import "ScreenHelper.h"

//Material Design
#import <PDSnackbar/PDSnackbar.h>
#import <MaterialTextField/MaterialTextField.h>
#import <MaterialButtons.h>
#import <MaterialComponents/MaterialCards.h>
#import <MaterialComponents/MaterialNavigationDrawer.h>

#import <MaterialComponents/MDCFloatingButton.h>
#import <MaterialComponents/MDCFloatingButton+MaterialTheming.h>
#import <MaterialComponents/MaterialBottomAppBar.h>

@implementation RootDashboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self ConfigureCards];
    [self configureRefreshComponent];
    [self setNavigationBarComponents];
    [self checkAuthStatus];
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
    
    [SnackBarHelper showSnackBarWithMessage:@"Welcome to SafetyBox!"];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void) refreshCards {
    //Refresh all Dashboard Components
    //Invoke the RootDashboard Helper Service, that will contain the Rest Service required for dragging items from the local device and from the server
    
    //self._notesCard._categoryItemsCount.text = @"(40) >";
}

-(void)SetupOtherUIComponents {
    
    //Bottom Bar
    
    //Refresh Floating Button
    
    
}

#pragma mark - Load the
-(void)ConfigureCards {
    
#pragma mark -- Categories
    
    //Passwords
    self._notesCard = [[DashboardCardView alloc] initWithOptions:(int)Notes frameOption:CGRectMake(15.0f, self.navigationController.navigationBar.bounds.size.height - 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
    self._passwordsCard = [[DashboardCardView alloc] initWithOptions:(int)Passwords frameOption:CGRectMake(15.0f, self._notesCard.frame.origin.y + self._notesCard.bounds.size.height + 20.0f, [ScreenHelper GetScreenWidth] - 30.0f, 300.0f) controllerOption:self];
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

#pragma mark Navigation Logic (Bottom Drawer, Menu Drawer for accounts)

-(void) setNavigationBarComponents{
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(promptNewContent)]];
    
    //Menu Option
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(promptSideMenuDrawer)]];
    
    
    //Bottom Tab Bar
//    self._bottomTabBar = [[MDCBottomNavigationBar alloc] init];
//    self._bottomTabBar.sizeThatFitsIncludesSafeArea = false;
//    [self layoutBottomNavBar];
//
//    UITabBarItem* item = [[UITabBarItem alloc] initWithTitle:@"Dashboard" image:@"Dashboard_NotesIcon" tag:0];
//    [self._bottomTabBar setItems:[[NSArray alloc] initWithObjects:item]];
}

- (void)layoutBottomNavBar {
    CGRect viewBounds = CGRectStandardize(self.view.bounds);
    CGSize size = [self._bottomTabBar sizeThatFits:viewBounds.size];
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
    // Extend the Bottom Navigation to the bottom of the screen.
    if (@available(iOS 11.0, *)){
        safeAreaInsets = self.view.safeAreaInsets;
    }
    CGRect bottomNavBarFrame =
    CGRectMake(0, viewBounds.size.height - size.height - safeAreaInsets.bottom, size.width,
               size.height + safeAreaInsets.bottom);
    self._bottomTabBar.frame = bottomNavBarFrame;
}

-(void)promptNewContent{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:5];
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Notes" image:@"Dashboard_NotesIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Passwords" image:@"Dashboard_PasswordsIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Documents" image:@"Dashboard_DocumentsIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"PDFs" image:@"Dashboard_PDFIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Photos & Videos" image:@"Dashboard_PhotosVideosIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Emails" image:@"Dashboard_EmailsIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Music & Albums" image:@"Dashboard_MusicIcon" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    
    [DialogHelper showActionSheetWithSimpleMessage:@"" dialogues:actions controller:self];
}

-(void)promptSideMenuDrawer{
    
    NSLog(@"Opening Menu Drawer");
}

@end
