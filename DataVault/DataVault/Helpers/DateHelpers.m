//
//  DateHelpers.m
//  DataVault
//
//  Created by Assassin on 8/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "DateHelpers.h"

#import <Foundation/Foundation.h>

@implementation DateHelpers
+(NSString *) getFormattedDate:(NSDate *)date{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"dd MMM yyyy - HH:mm"];
//
//    //Optionally for time zone conversions
//    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
//
//    return [formatter stringFromDate:date];
    
    return [NSDateFormatter localizedStringFromDate:date
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterFullStyle];
}
@end
