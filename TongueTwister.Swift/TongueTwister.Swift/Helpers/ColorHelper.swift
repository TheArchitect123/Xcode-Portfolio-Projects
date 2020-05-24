//
//  ColorHelpers.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import UIColor_Hex;

 internal struct ColorHelper{
    
    #warning("Colour Constants - For Common Functions")
    public static func Indigo() -> UIColor { return FromHex(0x4b0082);}
    public static func LightOrange() -> UIColor { return FromHex(0xffa500);}
    
    #warning("Color Functions for View Components")
    public static func Card_DarkThemeBackground() -> UIColor { return FromHex(0x041a2f);}
    public static func NavBar_DarkThemeBackground() -> UIColor { return UIColor.lightGray;}
    public static func FloatButton_DarkThemeBackground() -> UIColor { return UIColor.red;}
    
    
    #warning("Helper functions to manage colour conversions")
    internal static func FromHex(_ hexValue: UInt) -> UIColor {
        return UIColor.init(hex: hexValue);
    }
}
