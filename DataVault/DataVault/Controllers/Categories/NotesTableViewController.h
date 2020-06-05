//
//  NotesTableViewController.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

//Headers
#import "NotesDashSource.h"

//Libraries
#import <UIKit/UIKit.h>

@interface NotesTableViewController : UITableViewController

@property(nonatomic, readwrite, strong) NotesDashSource* DataSource;
@end
