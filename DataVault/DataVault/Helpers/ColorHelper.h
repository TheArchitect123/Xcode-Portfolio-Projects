//
//  ColorHelper.h
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ColorHelper : NSObject

+(UIColor *) Indigo;
+(UIColor *) LightOrange;
+(UIColor *) DarkOrange;
+(UIColor *) Teal;
+(UIColor *) CardDark_ThemBackground;
+(UIColor *) NavBar_DarkThemeBackground;
+(UIColor *) FloatButton_DarkThemeBackground;
+(UIColor *)colorWithHexString:(NSString *)stringToConvert;

@end
