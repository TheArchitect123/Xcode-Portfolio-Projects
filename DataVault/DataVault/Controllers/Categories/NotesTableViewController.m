//
//  NotesTableViewController.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "NotesTableViewController.h"
#import "NotesPostViewController.h"
#import "DocumentsDashSource.h"

//Material
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

-(void) refreshItems{
    [self.tableView.refreshControl endRefreshing];
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

-(void) createNewNote {
    //Opens up the modal dialogue of the note, allowing the user to edit it.
    //This will make an upload to the cloud, while also updating the items on the local database
    UIStoryboard* storyRef = [UIStoryboard storyboardWithName:@"SafetyBoxStory" bundle:nil];
    NotesPostViewController *notesPostController = [storyRef instantiateViewControllerWithIdentifier:@"NotesPostViewController"];
    
    notesPostController.completionBlock = ^(NSString *s, NSString *e) {
        [self.DataSource createNewNote:s description:e];
        
        //After adding the item, make sure to refresh the table
        [self.tableView reloadData];
    };
    
    [self.navigationController pushViewController:notesPostController animated:true];
}

-(void) setNavigationBarComponents{
    self.navigationController.navigationBar.backgroundColor = UIColor.lightGrayColor;
    
    //Add Option
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createNewNote)]];
    
}

@end
