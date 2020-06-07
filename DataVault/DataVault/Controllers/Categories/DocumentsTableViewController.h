//
//  DocumentsTableViewController.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>

//Custom
#import "BaseViewController.h"
#import "DocumentsDashSource.h"

//Helpers
#import "DialogHelper.h"
#import "MediaHelpers.h"

@interface DocumentsTableViewController : BaseViewController<UIDocumentPickerDelegate>

@property(nonatomic, readwrite, strong) DocumentsDashSource* DataSource;

@end
