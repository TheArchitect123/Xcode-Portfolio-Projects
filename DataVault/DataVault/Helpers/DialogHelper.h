//
//  DialogHelper.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Material Components
#import <MaterialComponents/MaterialActionSheet.h>
#import <MaterialComponents/MaterialDialogs+Theming.h>


@interface DialogHelper : NSObject

+(void) showDialogueWithSimpleMessage:(NSString *)message controller: (UIViewController *) controllerRef;
+(void) showDialogueWithTopicSimpleMessage:(NSString *)title messageRef:(NSString *)message controller: (UIViewController *) controllerRef;
+(void) showDialogueWithTopicSimpleMessageAction:(NSString *)title messageRef:(NSString *)message action:(void(^)())actionOutcome controller:(UIViewController *) controllerRef;

+(void) showActionSheetWithSimpleMessage:(NSString *)message dialogues:(NSMutableArray*) dialogueOptions controller:(UIViewController *)controllerRef;



+(MDCActionSheetAction *) actionSheetCreator: (NSString *) name action:(void (^)())actionOption;
+(MDCActionSheetAction *) actionSheetCreatorWithImage: (NSString *) name image:(NSString *)imagePath action:(void (^)())actionOption;

@end

