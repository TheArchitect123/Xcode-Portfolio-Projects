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

@interface VideosDashSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UIViewController* _parentController;
@property(nonatomic, strong, readwrite) VideosDataArray* _dataArray;

@end
