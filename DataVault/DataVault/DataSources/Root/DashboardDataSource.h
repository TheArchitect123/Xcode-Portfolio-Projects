//
//  DashboardDataSource.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DashboardDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong, readwrite) NSArray* _imageItems;
@property(nonatomic, strong, readwrite) UIViewController* _parentController;

@end
