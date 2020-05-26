//
//  LoaderHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 26/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import SVProgressHUD;

internal class LoaderHelper {
    public static func ConfigureLoaderDefaults(){
        SVProgressHUD.setDefaultMaskType(.clear);
        SVProgressHUD.setBackgroundColor(ColorHelper.Card_DarkThemeBackground());
        SVProgressHUD.setForegroundColor(UIColor.white);
        SVProgressHUD.setBorderColor(UIColor.white);
        SVProgressHUD.setBorderWidth(0.5);
    }
    
    public static func ShowLoaderWithDefault(){
        SVProgressHUD.show();
    }
    
    public static func DismissLoaderWithDefault(){
        SVProgressHUD.dismiss();
       }
    
    public static func ShowLoaderWithMessage(_ message: String){
        SVProgressHUD.show(withStatus: message);
    }
    
    public static func ShowLoaderWithProgress(_ progress: Float){
         SVProgressHUD.showProgress(progress);
     }
}
