//
//  VideosViewController.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "VideosViewController.h"
#import "VideosDashSource.h"

//Helpers
#import "DialogHelper.h"
#import "MediaHelpers.h"

@interface VideosViewController ()

@end

@implementation VideosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureDocumentsPage];
    [self configureRefreshComponent];
    [self setupOtherUIComponents];
    [self setNavigationBarComponents];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void) setupOtherUIComponents {
    
    //Bottom Bar
    
}

-(void) pickImportDocument{
    [MediaHelpers takeDocumentFromLocalDevice:self];
}

-(void) refreshItems{
    [self.tableView.refreshControl endRefreshing];
}

#pragma mark - Load the DataSource (Dashboard DataSource)
-(void) configureDocumentsPage {
    
    self.DataSource = [[VideosDashSource alloc] init];
    self.DataSource._parentController = self;
    
    self.tableView.dataSource = self.DataSource;
    self.tableView.delegate = self.DataSource;
    self.tableView.rowHeight = 100.0f;
    self.tableView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
}

-(void) configureRefreshComponent{
    UIRefreshControl* refreshDashboard = [[UIRefreshControl alloc] init];
    [refreshDashboard addTarget:self action:@selector(refreshItems) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = refreshDashboard;
}

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(promptCameraSetup)]];
}

-(void) promptCameraSetup{
    
    //Opens the bottom drawer
    NSMutableArray* actions = [[NSMutableArray alloc] initWithCapacity:3];
   [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Camera" image:@"Dashboard_VideosIcon" action:(^() {
        
       [MediaHelpers takeVideoFromCamera:self];
    })]];
    
    [actions addObject: [DialogHelper actionSheetCreatorWithImage:@"Gallery" image:@"Dashboard_GalleryIcon" action:(^() {
         
        [MediaHelpers selectVideoGallery:self];
     })]];
    
    [DialogHelper showActionSheetWithSimpleMessage:@"Add a video either from the video gallery or the camera" dialogues:actions controller:self];
}

@end
