//
//  PDSnackbar.m
//  snackbar
//
//  Created by Stanislav Proskurnin on 10/02/16.
//  Copyright © 2016 Prime Digital. All rights reserved.
//

#import "PDSnackbar.h"
#import <PureLayout/PureLayout.h>

static CGFloat const PDSnackbarAnimationDuration = 0.2;

@implementation PDSnackbar {
    UILabel                 *_messageLabel;
    UIButton                *_actionButton;
    UIActivityIndicatorView *_activityIndicator;
    SnackbarDurationTime    _durationTime;
    NSTimer                 *_timer;
    ActionBlock             _actionBlock;
    TouchBlock              _touchBlock;
}

@synthesize multiline = _multiline;

#pragma mark init

- (instancetype)initSnackBarWithMessage:(NSString *)message
                               duration:(SnackbarDurationTime)durationTime {
    self = [super init];
    if (self) {
        PDSnackbarOptions *pdOptions = [PDSnackbarOptions sharedInstance];
        self.frame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? pdOptions.frameIPad : pdOptions.frameIPhone;
        _durationTime = durationTime;

        [self createMessageLabel];
        _messageLabel.text = message;
        _messageLabel.textColor = pdOptions.textColor;
        _messageLabel.font = pdOptions.textFont;

        _transparency = 0.95;
        self.backgroundColor = [UIColor whiteColor];

        self.layer.shadowRadius  = 3.f;
        self.layer.shadowOpacity = 0.5f;
        self.layer.shadowColor   = [UIColor grayColor].CGColor;
        self.layer.shadowOffset  = CGSizeZero;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
        self.layer.masksToBounds = NO;

        self.alpha = 0.f;
    }
    return self;
}

- (instancetype)initSnackBarWithMessage:(NSString *)message
                               duration:(SnackbarDurationTime)durationTime
                             touchBlock:(TouchBlock)touchBlock {
    self = [self initSnackBarWithMessage:message duration:durationTime];
    if (self) {
        UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(touchBlockTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGestureRecognizer];
        self.userInteractionEnabled = YES;
        _touchBlock = touchBlock;
    }
    return self;
}

- (instancetype)initActionSnackBarWithMessage:(NSString *)message
                                  actionTitle:(NSString *)actionTitle
                                  actionBlock:(ActionBlock)actionBlock
                                     duration:(SnackbarDurationTime)durationTime {
    self = [self initSnackBarWithMessage:message
                                duration:durationTime];
    if (self) {
        [self createActionButton];
        [_actionButton setTitle:actionTitle
                       forState:UIControlStateNormal];
        [_actionButton addTarget:self
                          action:@selector(actionButtonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
        _actionButton.titleLabel.font = [PDSnackbarOptions sharedInstance].buttonTitleFont;
        _actionBlock = actionBlock;
    }
    return self;
}

- (instancetype)initIndicatorSnackBarWithMessage:(NSString *)message
                                        duration:(SnackbarDurationTime)durationTime {
    self = [self initSnackBarWithMessage:message
                                duration:durationTime];
    if (self) {
        [self createIndicatorView];
    }
    return self;
}

#pragma mark - Dealloc

- (void)dealloc {
    [_timer invalidate];
    _timer = nil;
}

#pragma mark Custom Setters

- (void)setMultiline:(BOOL)multiline {
    _multiline = multiline;
    _messageLabel.numberOfLines = multiline ? 0 : 1;
}

- (void)setActionTitleColor:(UIColor *)actionTitleColor {
    _actionTitleColor = actionTitleColor;
    [_actionButton setTitleColor:actionTitleColor
                        forState:UIControlStateNormal];
}

- (void)setMessageLabelTextColor:(UIColor *)messageLabelTextColor {
    _messageLabelTextColor = messageLabelTextColor;
    _messageLabel.textColor = messageLabelTextColor;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLabel.text = message;
}

- (void)setMessageFont:(UIFont *)messageFont {
    _messageFont = messageFont;
    _messageLabel.font = messageFont;
}

- (void)setActionButtonFont:(UIFont *)actionButtonFont {
    _actionButtonFont = actionButtonFont;
    _actionButton.titleLabel.font = actionButtonFont;
}

#pragma mark - Create Content

- (void)createMessageLabel {
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.numberOfLines = 1;
    [self addSubview:_messageLabel];

    [_messageLabel autoAlignAxis:ALAxisHorizontal
                toSameAxisOfView:self];
    [_messageLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft
                                    withInset:20.f];
    [_messageLabel autoPinEdgeToSuperviewEdge:ALEdgeTop
                                    withInset:10.f];
    [_messageLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom
                                    withInset:10.f];
    [_messageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                    withInset:25.f];
}

- (void)createIndicatorView {
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.25f, 1.25f);
    _activityIndicator.transform = transform;

    [self addSubview:_activityIndicator];

    [_activityIndicator autoAlignAxis:ALAxisHorizontal
                     toSameAxisOfView:_messageLabel];
    [_activityIndicator autoPinEdgeToSuperviewEdge:ALEdgeRight
                                         withInset:25.f];
    [_messageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                    withInset:55.f];
    [_messageLabel autoPinEdge:ALEdgeRight
                        toEdge:ALEdgeLeft
                        ofView:_activityIndicator
                    withOffset:10];
}

- (void)createActionButton {
    _actionButton = [[UIButton alloc] init];
    [_actionButton setTitleColor:[PDSnackbarOptions sharedInstance].buttonTitleHighlighted
                        forState:UIControlStateHighlighted];
    [_actionButton setTitleColor:[PDSnackbarOptions sharedInstance].buttonTitleColor
                        forState:UIControlStateNormal];
    [self addSubview:_actionButton];

    [_actionButton autoAlignAxis:ALAxisHorizontal
                toSameAxisOfView:_messageLabel];
    [_actionButton autoPinEdgeToSuperviewEdge:ALEdgeRight
                                    withInset:10.f];
    [_actionButton autoPinEdge:ALEdgeLeft
                        toEdge:ALEdgeRight
                        ofView:_messageLabel
                    withOffset:10.f];
    [_messageLabel autoPinEdgeToSuperviewEdge:ALEdgeRight
                                    withInset:120.f];
}

#pragma mark - Action

- (void)actionButtonTapped:(id)sender {
    if (_actionBlock) {
        _actionBlock();
    }
    [self hide];
}

- (void)touchBlockTapped:(id)sender {
    if (_touchBlock) {
        _touchBlock();
    }
    [self hide];
}

- (void)show {
    for (UIView *view in [[PDSnackbarOptions sharedInstance] containerView].subviews) {
        if ([view isKindOfClass:PDSnackbar.class]) {
            return;
        }
    }
    
    [[PDSnackbarOptions sharedInstance].containerView addSubview:self];
    [self addSwipeGestures];
    [_activityIndicator startAnimating];
    [UIView animateWithDuration:PDSnackbarAnimationDuration
                     animations:^{
                         self.alpha = self.transparency;
                         CGRect newFrame = self.frame;
                         newFrame.origin.y = self.frame.origin.y - self.frame.size.height;
                         self.frame = newFrame;
                     }];
    
    if (_actionBlock || _activityIndicator) {
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:(self.duration > 0) ? self.duration : (double)_durationTime
                                              target:self
                                            selector:@selector(hide)
                                            userInfo:nil
                                             repeats:NO];
}

- (void)hide {
    [_timer invalidate];
    _timer = nil;
    [UIView animateWithDuration:PDSnackbarAnimationDuration
                     animations:^{
                         self.alpha = 0.f;
                         CGRect newFrame = self.frame;
                         newFrame.origin.y = [[PDSnackbarOptions sharedInstance] containerView].frame.size.height;
                         self.frame = newFrame;
                     }
                     completion:^(BOOL finished) {
                         self.hidden = YES;
                         [self removeFromSuperview];
                         [_activityIndicator stopAnimating];
                     }];
}

#pragma mark - UISwipeGestureRecognizer

- (void)addSwipeGestures {
    UISwipeGestureRecognizer *downSwipeGestureRecognizer =
            [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(downSwipe:)];
    downSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self addGestureRecognizer:downSwipeGestureRecognizer];
}

- (void)downSwipe:(UISwipeGestureRecognizer *)swipeGestureRecognizer {
    [self hide];
}

@end