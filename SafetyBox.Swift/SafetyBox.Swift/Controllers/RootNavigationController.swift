//
//  RootNavigationController.swift
//  SafetyBox.Swift
//
//  Created by Assassin on 31/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Material;

class RootNavigationController : NavigationController {
    public override func viewDidLoad() {
        super.viewDidLoad();
        ConfigureMotionNavigation();
    }
    
    fileprivate func ConfigureMotionNavigation(){
        self.isMotionEnabled = true;
        self.motionNavigationTransitionType = .autoReverse(presenting: .zoom)
    }
}
