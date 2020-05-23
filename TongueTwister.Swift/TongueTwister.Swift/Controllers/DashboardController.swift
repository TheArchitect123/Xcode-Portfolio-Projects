//
//  DashboardController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import SVProgressHUD;

//This controller will be used for rendering the Material Cards
internal class DashboardController : UIViewController{
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark);
        SVProgressHUD.show(withStatus: "AHAHHHA MAMAHHA!")
        
        self.view.backgroundColor = UIColor.white;
    }
}
