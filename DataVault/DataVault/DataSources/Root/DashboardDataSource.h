//
//  DashboardDataSource.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "DatabaseHelper.h"

@interface DashboardDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) NSArray* _imageItems;
@property(nonatomic, strong, readwrite) UITabBarController* _parentController;
@property(nonatomic, strong, readwrite) DatabaseHelper* _dbHelper;
@property(nonatomic, strong, readwrite) NSMutableArray<NSString *>* _dataArray;

@end
