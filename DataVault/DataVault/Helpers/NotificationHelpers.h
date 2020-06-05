//
//  NotificationHelpers.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface NotificationHelpers : NSObject

+(BOOL) generateLocalNotification:(NSString*) message;

@end
