//
//  DocumentsTableViewController.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DocumentsTableViewController.h"
#import "DocumentsDashSource.h"

//Helpers
#import "DialogHelper.h"
#import "MediaHelpers.h"

@implementation DocumentsTableViewController

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
    
    self.DataSource = [[DocumentsDashSource alloc] init];
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
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pickImportDocument)]];
}

#pragma mark -- DocumentPicker Delegate

-(void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls{
    
    //When selecting a document, the user will be able to add an item directly into the data array of the data source, which will in turn add the items to the database
    for (NSURL* item in urls){
        //Process the urls in the background, and make sure to convert them to NSData for storage
        
        //NSData* test = [[NSData alloc] initWithContentsOfURL:item];
      //  NSLog(item); //Output the results;
    }
    
    [self.tableView reloadData];
}

-(void) documentPickerWasCancelled:(UIDocumentPickerViewController *)controller{
    NSLog(@"Cancelled Document Picker");
}
@end
