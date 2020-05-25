//
//  UIHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 24/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;


 internal struct UIHelper {
    public static var ScreenWidth : Double = Double(UIScreen.main.bounds.width);
    public static var ScreenHeight : Double = Double(UIScreen.main.bounds.height);
    
    public static func GetMaxYCoordinate(_ view : UIView) -> Double {
        return Double((view.frame.origin.y + view.frame.size.height));
    }
    public static func GetMaxXCoordinate(_ view: UIView) -> Double {
        return Double((view.frame.origin.y + view.frame.size.height));
    }
    
    public static var ActiveViewController : UIViewController
    {
        get{
            var window = UIApplication.shared.keyWindow
            if(window != nil){
               return (UIApplication.shared.keyWindow?.rootViewController?.navigationController?.visibleViewController!)!;
            }
            return UIViewController.init();
        }
    }
}
