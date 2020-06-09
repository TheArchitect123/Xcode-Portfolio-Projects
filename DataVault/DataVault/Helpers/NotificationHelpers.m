//
//  NotificationHelpers.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "NotificationHelpers.h"
#import <UserNotifications/UserNotifications.h>
#import <UIKit/UIKit.h>

@implementation NotificationHelpers

+(void) generateLocalNotification:(NSString*) message{
    
  UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"SafetyBox" arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:message
                arguments:nil];
    content.sound = [UNNotificationSound defaultSound];

    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:@"NotifSetting"
                content:content trigger:nil];

    // Schedule the notification.
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}
@end
