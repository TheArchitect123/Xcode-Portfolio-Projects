//
//  SnackBarHelper.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SnackBarHelper : NSObject

+(void) showSnackBarWithMessage:(NSString *)message;
+(void) showSnackBarWithActionedMessage:(NSString *) message invokedAction:(void (^)())actionInvoked;
+(void) showSnackBarWithCustomBtnActionedMessage:(NSString *) message buttonTitle:(NSString *)buttonTtl invokedAction:(void (^)())actionInvoked;

@end
