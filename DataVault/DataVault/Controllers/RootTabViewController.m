//
//  RootTabViewController.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "RootTabViewController.h"
#import "RootDashboardController.h"
#import "RootSearchViewController.h"
#import "RootSettingsViewController.h"
#import "ScreenHelper.h"

//Apple
#import <UIKit/UIKit.h>

//Helpers
#import "ColorHelper.h"
#import "DialogHelper.h"
#import "SnackBarHelper.h"

//Material Components
#import <MaterialComponents/MaterialBottomAppBar.h>
#import <MaterialComponents/MDCFloatingButton.h>
#import <MaterialComponents/MDCFloatingButton+MaterialTheming.h>

@implementation RootTabViewController

-(void) viewDidLoad{
    //Replace the Bottom Tab Bar with the material Bar
    
    [self configureAppBarItems];
    [self configureControllers];
    [self configureBottomBarBehaviour];
    [self setNavigationBarComponents];
    [self setupOtherUIComponents];
}

//Each page with a table controller needs to listen for when it is selected so that it can adjust its edge insets to avoid having any issues with the margin from the navigation bar
//To SIMULATE: Press on Tab Bar from Dashboard to Search Button

-(void) enableUINotifications{
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(recreateViewsRequiredForConstraints) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void) disposeUINotifications{
    [NSNotificationCenter.defaultCenter removeObserver:nil name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void) viewWillAppear:(BOOL)animated{
    [self enableUINotifications];
}

-(void) viewWillDisappear:(BOOL)animated{
    
    [self disposeUINotifications];
}

-(void) recreateViewsRequiredForConstraints{
    //Refresh btn Constraints
    self._refreshFloatBtn.frame = CGRectMake(self.view.bounds.size.width - 100.0f, self.view.bounds.size.height - 160.0f, 80.0f, 80.0f);
}



-(void) setupOtherUIComponents{
    
    //Refresh Floating Button
    self._refreshFloatBtn = [[MDCFloatingButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 100.0f, self.view.bounds.size.height - 160.0f, 80.0f, 80.0f)];
    self._refreshFloatBtn.backgroundColor = [ColorHelper CardDark_ThemBackground];
    [self._refreshFloatBtn setImage:[UIImage imageNamed:@"RefreshWhite"] forState:UIControlStateNormal];
    [self._refreshFloatBtn addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:self._refreshFloatBtn];
}

-(void) configureAppBarItems{
    [self.tabBar setHidden:true];
    self._bottomNavBar = [[MDCBottomNavigationBar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60.0f, [ScreenHelper GetScreenWidth], 60.0f)];
    self._bottomNavBar.delegate = self;
    
    [self.view addSubview:self._bottomNavBar];
}

-(void) configureBottomBarBehaviour{
    self._bottomNavBar.selectedItemTitleColor = [ColorHelper CardDark_ThemBackground];
    self._bottomNavBar.selectedItemTintColor = [ColorHelper CardDark_ThemBackground];
    
    self._bottomNavBar.elevation = 2.0f;
    self._bottomNavBar.backgroundBlurEffectStyle = UIBlurEffectStyleProminent;
    
    self._bottomNavBar.selectedItem = self.viewControllers[0].tabBarItem;
}

-(void) refreshItems{
    [SnackBarHelper showSnackBarWithMessage:@"Refreshing Items"];
}

- (void)bottomNavigationBar:(MDCBottomNavigationBar *)bottomNavigationBar didSelectItem:(UITabBarItem *)item{
    //On Selection make sure to switch the active view controller
    self.selectedViewController = self.viewControllers[item.tag];
}


#pragma mark Navigation Logic (Bottom Drawer, Menu Drawer for accounts)

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(promptNewContent)]];
    
    //Cloud Storage
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(promptCloudStorageSetup)]];
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
    
    [DialogHelper showActionSheetWithSimpleMessage:@"You can add new content for the selected category by clicking on them..." dialogues:actions controller:self];
}

-(void) promptCloudStorageSetup{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:3];
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Setup Microsoft OneDrive" image:@"CloudSetup_Win" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Setup Google Drive" image:@"CloudSetup_Google" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Setup Apple iCloud" image:@"CloudSetup_Apple" action:(^() {
        
        //Show the add notes page as a modal page -- this will allow users to post notes, and to add it into their storage accounts of choice (OneDrive, Outlook, GoogleDrive, etc)
    })]];
    
    [DialogHelper showActionSheetWithSimpleMessage:@"Integrate SafetyBox with your cloud storage provider of choice" dialogues:actions controller:self];
}


-(void) configureControllers{
    
    UIStoryboard* storyMngr = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    
    RootDashboardController* dashboardController = [storyMngr instantiateViewControllerWithIdentifier:@"RootDashboardController"];
    dashboardController.tabBarItem.title = @"Dashboard";
    dashboardController.tabBarItem.image = [UIImage imageNamed:@"DashboardTab"];
    dashboardController.tabBarItem.tag = 0;
    
    RootSearchViewController* searchController = [storyMngr instantiateViewControllerWithIdentifier:@"RootSearchViewController"];
    searchController.tabBarItem.title = @"Search";
    searchController.tabBarItem.image = [UIImage imageNamed:@"SearchTab"];
    searchController.tabBarItem.tag = 1;
    
    RootSettingsViewController* settingsController = [storyMngr instantiateViewControllerWithIdentifier:@"RootSettingsViewController"];
    settingsController.tabBarItem.title = @"Settings";
    settingsController.tabBarItem.image = [UIImage imageNamed:@"SettingsTab"];
    settingsController.tabBarItem.tag = 2;
    
    //Set the Tabs
    self._bottomNavBar.items = [[NSArray alloc] initWithObjects:dashboardController.tabBarItem, searchController.tabBarItem, settingsController.tabBarItem, nil];
    self.viewControllers = [[NSArray alloc] initWithObjects:dashboardController,searchController,settingsController, nil];
}

@end
