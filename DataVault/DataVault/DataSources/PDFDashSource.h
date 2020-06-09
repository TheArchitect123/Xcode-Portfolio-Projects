//
//  PDFDashSource.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "PDFsDataArray.h"
#import "DatabaseHelper.h"

@interface PDFDashSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UIViewController* _parentController;
@property(nonatomic, strong, readwrite) NSMutableArray<PDFsDto *>* _dataArray;
@property(nonatomic, strong, readwrite) DatabaseHelper* _dbHelper;

@end
