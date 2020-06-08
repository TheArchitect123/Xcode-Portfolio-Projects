//
//  VideosViewController.h
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideosDashSource.h"

//Custom
#import "BaseViewController.h"

@interface VideosViewController : BaseViewController<UIImagePickerControllerDelegate>


@property(nonatomic, readwrite, strong) VideosDashSource* DataSource;
@end
