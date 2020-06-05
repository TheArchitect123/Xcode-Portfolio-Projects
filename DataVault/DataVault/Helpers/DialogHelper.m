//
//  DialogHelper.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

//iOS
#import <Foundation/Foundation.h>

//Custom
#import "DialogHelper.h"

//Material Components
#import <MaterialComponents/MaterialDialogs.h>
#import <MaterialComponents/MaterialDialogs+Theming.h>


@implementation DialogHelper

+(void) showDialogueWithSimpleMessage:(NSString *)message controller: (UIViewController *) controllerRef{
    // Present a modal alert
    MDCAlertController *alertController =
    [MDCAlertController alertControllerWithTitle:@"Test"
                                         message:message];
    
    MDCAlertAction *alertAction =
    [MDCAlertAction actionWithTitle:@"OK"
                            handler:^(MDCAlertAction *action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:alertAction];
    [controllerRef presentViewController:alertController animated:YES completion:nil];
}

+(void) showDialogueWithTopicSimpleMessage:(NSString *)title messageRef:(NSString *)message controller: (UIViewController *) controllerRef{
    
    // Present a modal alert
    MDCAlertController *alertController =
    [MDCAlertController alertControllerWithTitle:title
                                         message:message];
    
    MDCAlertAction *alertAction =
    [MDCAlertAction actionWithTitle:@"OK"
                            handler:^(MDCAlertAction *action) {
        NSLog(@"OK");
    }];
    
    [alertController addAction:alertAction];
    [controllerRef presentViewController:alertController animated:YES completion:nil];
}
@end
