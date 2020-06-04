//
//  PDSnackbar.h
//  snackbar
//
//  Created by Stanislav Proskurnin on 10/02/16.
//  Copyright © 2016 Prime Digital. All rights reserved.
//


#import "PDSnackbarOptions.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SnackbarDurationTime) {
    SnackBarDurationTimeLong = 5,
    SnackBarDurationTimeShort = 2
};

typedef void (^ActionBlock)();
typedef void (^TouchBlock)();

@interface PDSnackbar : UIControl


@property (nonatomic) UIColor        *actionTitleColor;
@property (nonatomic) UIColor        *messageLabelTextColor;
@property (nonatomic) NSString       *message;
@property (nonatomic) UIFont         *actionButtonFont;
@property (nonatomic) UIFont         *messageFont;
@property (assign, nonatomic) CGFloat        transparency;
@property (assign, nonatomic) BOOL           multiline;
@property (assign, nonatomic) NSTimeInterval duration;

- (instancetype)initSnackBarWithMessage:(NSString *)message
                               duration:(SnackbarDurationTime)durationTime;

- (instancetype)initSnackBarWithMessage:(NSString *)message
                               duration:(SnackbarDurationTime)durationTime
                             touchBlock:(TouchBlock)touchBlock;

- (instancetype)initIndicatorSnackBarWithMessage:(NSString *)message
                                        duration:(SnackbarDurationTime)durationTime;

- (instancetype)initActionSnackBarWithMessage:(NSString *)message
                                  actionTitle:(NSString *)actionTitle
                                  actionBlock:(ActionBlock)actionBlock
                                     duration:(SnackbarDurationTime)durationTime;

- (void)show;

- (void)hide;

@end