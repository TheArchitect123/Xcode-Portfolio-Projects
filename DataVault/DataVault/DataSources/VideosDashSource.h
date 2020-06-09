//
//  VideosDashSource.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "VideosDataArray.h"
#import "VideosDashSource.h"

#import "VideosDto.h"
#import "DatabaseHelper.h"

@interface VideosDashSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UIViewController* _parentController;
@property(nonatomic, strong, readwrite) NSMutableArray<VideosDto *>* _dataArray;
@property(nonatomic, strong, readwrite) DatabaseHelper* _dbHelper;

@end
