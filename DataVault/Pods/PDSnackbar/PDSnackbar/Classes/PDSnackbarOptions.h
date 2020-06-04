//
//  PDSnackbarOptions.h
//  PDSnackbar
//
//  Created by Stanislav Proskurnin on 12/02/16.
//  Copyright © 2016 Prime Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern CGFloat const PDSnackbarHeight;

@interface PDSnackbarOptions : NSObject

@property (assign, nonatomic) CGRect  frameIPhone;
@property (assign, nonatomic) CGRect  frameIPad;
@property (strong, nonatomic) UIColor *textColor;
@property (strong, nonatomic) UIColor *buttonTitleColor;
@property (strong, nonatomic) UIColor *buttonTitleHighlighted;
@property (strong, nonatomic) UIFont  *buttonTitleFont;
@property (strong, nonatomic) UIFont  *textFont;

+ (instancetype)sharedInstance;

- (UIView *)containerView;

@end
