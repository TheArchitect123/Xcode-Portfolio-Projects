//
//  SnackBarHelper.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "SnackBarHelper.h"
#import <MaterialComponents/MaterialSnackbar.h>

@implementation SnackBarHelper

+(void) showSnackBarWithMessage:(NSString *)message{
    MDCSnackbarMessage* messageItem = [[MDCSnackbarMessage alloc] init];
    messageItem.text = message;
    messageItem.buttonTextColor = UIColor.greenColor;
    
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.title = @"Dismiss";

    messageItem.action = action;
    
    MDCSnackbarManager* snackBar = [[MDCSnackbarManager alloc] init];
    [snackBar showMessage:messageItem];
}

+(void) showSnackBarWithActionedMessage:(NSString *) message invokedAction:(void (^)())actionInvoked {
    MDCSnackbarMessage* messageItem = [[MDCSnackbarMessage alloc] init];
    messageItem.text = message;
    messageItem.buttonTextColor = UIColor.greenColor;
    
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.handler = actionInvoked;
    action.title = @"Done";
    
    messageItem.action = action;
    
    MDCSnackbarManager* snackBar = [[MDCSnackbarManager alloc] init];
    [snackBar showMessage:messageItem];
}

+(void) showSnackBarWithCustomBtnActionedMessage:(NSString *) message buttonTitle:(NSString *)buttonTtl invokedAction:(void (^)())actionInvoked {
    MDCSnackbarMessage* messageItem = [[MDCSnackbarMessage alloc] init];
    messageItem.text = message;
    messageItem.buttonTextColor = UIColor.greenColor;
    
    MDCSnackbarMessageAction *action = [[MDCSnackbarMessageAction alloc] init];
    action.handler = actionInvoked;
    action.title = buttonTtl;
    
    messageItem.action = action;
    
    MDCSnackbarManager* snackBar = [[MDCSnackbarManager alloc] init];
    [snackBar showMessage:messageItem];
}

@end
