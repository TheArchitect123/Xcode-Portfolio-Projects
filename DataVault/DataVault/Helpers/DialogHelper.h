//
//  DialogHelper.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface DialogHelper : NSObject

+(void) showDialogueWithSimpleMessage:(NSString *)message controller: (UIViewController *) controllerRef;
+(void) showDialogueWithTopicSimpleMessage:(NSString *)title messageRef:(NSString *)message controller: (UIViewController *) controllerRef;

@end

