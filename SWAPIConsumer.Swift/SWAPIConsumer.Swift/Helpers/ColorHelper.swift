//
//  ColorHelper.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import UIColor_Hex;

class ColorHelper{
    #warning("Colour Constants - For Common Functions")
    static func Indigo() -> UIColor { return FromHex(0x4b0082);}
    static func LightOrange() -> UIColor { return FromHex(0xffa500);}
    static func ForestGreen() -> UIColor {return FromHex(0x228C22);}
    
    #warning("Color Functions for View Components")
    static func DarkThemeBackground() -> UIColor { return FromHex(0x041a2f);}
    static func NavBar_DarkThemeBackground() -> UIColor { return FromHex(0x009696);}
    static func FloatButton_DarkThemeBackground() -> UIColor { return UIColor.red;}
    
    #warning("Helper functions to manage colour conversions")
    static func FromHex(_ hexValue: UInt) -> UIColor {
        return UIColor.init(hex: hexValue) as! UIColor;
    }
}
