//
//  NotesTableViewController.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "NotesTableViewController.h"

@implementation NotesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self.DataSource;
    
}

-(void) configureDataSource{
    
    self.DataSource = [[NotesDashSource alloc] init];
    self.tableView.dataSource = self.DataSource;
}
@end
