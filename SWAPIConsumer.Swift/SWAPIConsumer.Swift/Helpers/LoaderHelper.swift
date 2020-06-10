//
//  LoaderHelper.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import SVProgressHUD;

class LoaderHelper {
    static func ConfigureLoaderDefaults(){
        SVProgressHUD.setDefaultMaskType(.clear);
        SVProgressHUD.setBackgroundColor(UIColor.black);
        SVProgressHUD.setForegroundColor(UIColor.white);
        SVProgressHUD.setBorderColor(UIColor.white);
        SVProgressHUD.setBorderWidth(0.5);
    }
    
    static func ShowLoaderWithDefault(){
        SVProgressHUD.show();
    }
    
    static func DismissLoaderWithDefault(){
        SVProgressHUD.dismiss();
    }
    
    static func ShowLoaderWithMessage(_ message: String){
        SVProgressHUD.show(withStatus: message);
    }
    
    static func ShowLoaderWithProgress(_ progress: Float){
        SVProgressHUD.showProgress(progress);
    }
}
