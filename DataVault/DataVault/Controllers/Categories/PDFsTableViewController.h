//
//  PDFsTableViewController.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>
//Custom
#import "BaseViewController.h"
#import "PDFDashSource.h"

@interface PDFsTableViewController : BaseViewController<UIDocumentPickerDelegate>

@property(nonatomic, readwrite, strong) PDFDashSource* DataSource;

@end
