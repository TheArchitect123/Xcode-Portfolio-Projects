//
//  NotesTableViewController.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NotesPostViewController.h"

#import "NotesDashSource.h"

#import <MaterialComponents/MDCBottomSheetController.h>

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self configureNotesPage];
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

-(void) refreshItems {
    
}

#pragma mark - Load the DataSource (Dashboard DataSource)
-(void) configureNotesPage {
    self.DataSource = [[NotesDashSource alloc] init];
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

-(void) createNewNote{
    NotesPostViewController *notesPostController = [[NotesPostViewController alloc] init];
    [self.navigationController pushViewController:notesPostController animated:true];
}

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewNote)]];
    
}

@end
