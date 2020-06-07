//
//  PhotosViewController.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotosDashSource.h"

//Custom
#import "BaseViewController.h"

@interface PhotosViewController : BaseViewController

@property(nonatomic, readwrite, strong) PhotosDashSource* DataSource;

@end
