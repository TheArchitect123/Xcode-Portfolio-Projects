//
//  BaseViewController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

internal class BaseViewController : UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.lightGray;
        self.isMotionEnabled = true;
        if(!(self is DashboardController)){
            self.view.addGestureRecognizer(UISwipeGestureRecognizer.init(target: self, action: #selector(PopPage)));
        }
    }
    
    @objc fileprivate func PopPage(){
        self.navigationController?.popViewController(animated: true);
    }
    
    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if(!(self is DashboardController)){
            PopPage();
        }
    }
}
