//
//  ColorHelper.m
//  DataVault
//
//  Created by Assassin on 6/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

#import "ColorHelper.h"
#import <UIKit/UIKit.h>

@implementation ColorHelper
 
+(UIColor *) Indigo {
    return [self colorWithHexString:@"#082050"];
}

+(UIColor *) LightOrange{
    return [self colorWithHexString:@"#ffa500"];
}

+(UIColor *) DarkOrange{
    return [self colorWithHexString:@"#F76917"];
}

+(UIColor *) CardDark_ThemBackground{
    return [self colorWithHexString:@"#082050"];
}
+(UIColor *) NavBar_DarkThemeBackground{
    return [self colorWithHexString:@"#041a2f"];
}
+(UIColor *) FloatButton_DarkThemeBackground{
    return UIColor.redColor;
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
    NSScanner *scanner = [NSScanner scannerWithString:noHashString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $

    unsigned hex;
    if (![scanner scanHexInt:&hex]) return nil;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

//    #warning("Colour Constants - For Common Functions")
//    public static func Indigo() -> UIColor { return FromHex(0x4b0082);}
//    public static func LightOrange() -> UIColor { return FromHex(0xffa500);}
//
//    #warning("Color Functions for View Components")
//    public static func Card_DarkThemeBackground() -> UIColor { return FromHex(0x041a2f);}
//    public static func NavBar_DarkThemeBackground() -> UIColor { return FromHex(0x009696);}
//    public static func FloatButton_DarkThemeBackground() -> UIColor { return UIColor.red;}
//
//
//    #warning("Helper functions to manage colour conversions")
//    internal static func FromHex(_ hexValue: UInt) -> UIColor {
//        return UIColor.init(hex: hexValue);
//    }

@end
