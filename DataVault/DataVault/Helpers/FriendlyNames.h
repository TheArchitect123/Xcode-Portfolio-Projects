//
//  FriendlyNames.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enums.h"

@interface FriendlyNames : NSObject
+(NSString*) getCategoryNameForOption: (CategoriesOptions)options;
+(NSString*) getCategoryBackgroundForOption: (CategoriesOptions)options;
@end
