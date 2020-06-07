//
//  PhotosDashSource.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhotosDataArray.h"
#import <UIKit/UIKit.h>

@interface PhotosDashSource : NSObject<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) UIViewController* _parentController;
@property(nonatomic, strong, readwrite) PhotosDataArray* _dataArray;

@end
