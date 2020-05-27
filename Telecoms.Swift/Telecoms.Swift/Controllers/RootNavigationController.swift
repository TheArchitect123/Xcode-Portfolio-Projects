//
//  RootNavigationController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Material;
import Motion;

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
