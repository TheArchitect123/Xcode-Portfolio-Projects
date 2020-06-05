//
//  Categories.h
//  DataVault
//
//  Created by Assassin on 5/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//
#import <Foundation/Foundation.h>



@interface Categories : NSObject


@end

enum {
    Passwords = 0,
    Photos = 1,
    Notes = 2,
    Emails = 3,
    Documents = 4,
    PDFs = 5,
    Music = 6
};
typedef NSInteger CategoriesOptions;
