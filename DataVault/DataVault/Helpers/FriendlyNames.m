//
//  FriendlyNames.m
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "FriendlyNames.h"
#import "Enums.h"
#import <Foundation/Foundation.h>

@implementation FriendlyNames

+(NSString*) getCategoryNameForOption: (CategoriesOptions)options{
    switch (options) {
        case Passwords:
            return @"Passwords";
            break;
            
        case Documents:
            return @"Documents";
            break;
            
        case PDFs:
            return @"PDFs";
            break;
            
        case Photos:
            return @"Photos & Videos";
            break;
            
        case Notes:
            return @"Notes";
            break;
        case Emails:
            return @"Emails";
            break;
            
        case Music:
            return @"Music & Albums";
            break;
            
        default:
            return @"";
            break;
    }
}

+(NSString*) getCategoryBackgroundForOption: (CategoriesOptions)options{
    switch (options) {
        case Passwords:
            return @"mt_bg_1.jpg";
            break;
            
        case Documents:
            return @"mt_bg_2.jpg";
            break;
            
        case PDFs:
            return @"mt_bg_3.jpg";
            break;
            
        case Photos:
            return @"mt_bg_4.jpg";
            break;
            
        case Notes:
            return @"mt_bg_5.jpg";
            break;
        case Emails:
            return @"mt_bg_6.jpg";
            break;
            
        case Music:
            return @"mt_bg_7.jpg";
            break;
        default:
            return @"";
            break;
    }
}


@end
