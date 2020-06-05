//
//  ScreenHelper.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "ScreenHelper.h"
#import <UIKit/UIKit.h>

@implementation ScreenHelper

+(double) GetScreenWidth {
    return UIScreen.mainScreen.bounds.size.width;
}

+(double) GetScreenHeight {
    return UIScreen.mainScreen.bounds.size.height;
}

@end
