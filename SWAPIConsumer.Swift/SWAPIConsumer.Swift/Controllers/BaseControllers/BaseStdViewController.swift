//
//  BaseStdViewController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 12/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Motion;
import Material;
import SVProgressHUD;
import Siesta;
import Toast_Swift;
import Alamofire;
import JSONParserSwift;

class BaseStdViewController : UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.white;
        
        self.isMotionEnabled = true;
        
        ConfigureSwipePops();
    }
    
    func ConfigureSwipePops(){
        self.view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(PopCurrentPage)));
    }
    
    @objc func PopCurrentPage() {
        if(!(self is RootTabBarController)){
            self.PopPage();
        }
    }
    
    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?)
    {
        PopCurrentPage();
    }
}

