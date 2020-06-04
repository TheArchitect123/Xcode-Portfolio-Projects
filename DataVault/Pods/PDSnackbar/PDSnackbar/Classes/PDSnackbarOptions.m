//
//  PDSnackbarOptions.m
//  PDSnackbar
//
//  Created by Stanislav Proskurnin on 12/02/16.
//  Copyright © 2016 Prime Digital. All rights reserved.
//

#define SNACKBAR_TEXT_COLOR [UIColor colorWithRed:72.f / 255.0f green:68.f / 255.0f blue:62.f / 255.0f alpha:255.f / 255.0f]
#define SNACKBAR_BUTTON_COLOR [UIColor colorWithRed:252.f / 255.0f green:117.f / 255.0f blue:31.f / 255.0f alpha:255.f / 255.0f]

#import "PDSnackbarOptions.h"

CGFloat const PDSnackbarHeight = 80.f;

static NSString * const PDSnackbarSFMediumFontName  = @"SFUIDisplay-Medium";
static NSString * const PDSnackbarSFRegularFontName = @"SFUIDisplay-Regular";

@implementation PDSnackbarOptions {
    UIView *_containerView;
}

+ (instancetype)sharedInstance {
    @synchronized ([PDSnackbarOptions class]) {
        static PDSnackbarOptions *singleton;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            singleton = [[self alloc] initUniqueInstance];
        });
        return singleton;
    }
}

- (instancetype)initUniqueInstance {
    self = [super init];
    if (self) {
        _containerView = [self containerView];
        CGRect snackbarFrame = CGRectMake(0, CGRectGetMaxY(_containerView.frame),
                                          CGRectGetWidth(_containerView.frame), PDSnackbarHeight);

        _frameIPad = snackbarFrame;
        _frameIPhone = snackbarFrame;
        _textColor = SNACKBAR_TEXT_COLOR;
        _buttonTitleColor =  SNACKBAR_BUTTON_COLOR;
        _buttonTitleHighlighted = SNACKBAR_TEXT_COLOR;
        _buttonTitleFont = [UIFont fontWithName:PDSnackbarSFMediumFontName
                                           size:16.f];;
        _textFont = [UIFont fontWithName:PDSnackbarSFRegularFontName
                                    size:16.f];;
    }
    return self;
}

#pragma mark - Container View

- (UIView *)containerView {
    if (!_containerView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 9.0) {
            UIWindow *window = [[UIApplication sharedApplication] keyWindow];
            if (!window)
                window = [UIApplication sharedApplication].windows[0];
            _containerView =  [window subviews].lastObject;
        } else {
            UIWindow *window =[[UIApplication sharedApplication] keyWindow];
            if (window == nil)
                window = [[[UIApplication sharedApplication] delegate] window];
            _containerView = window;
        }
    }
    return _containerView;
}

@end
