//
//  ModalDialogueHelper.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

//Apple
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Material Components
#import <MaterialComponents/MaterialActionSheet.h>
#import <MaterialComponents/MaterialDialogs+Theming.h>

@interface ModalDialogueHelper : NSObject

+(void) showDialogueWithSimpleMessage:(NSString *)message controller: (UIViewController *) controllerRef;
+(void) showDialogueWithTopicSimpleMessage:(NSString *)title messageRef:(NSString *)message controller: (UIViewController *) controllerRef;

@end
