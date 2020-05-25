//
//  RootNavController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Material;
import Motion;

internal class RootNavController : NavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.isMotionEnabled = true;
        self.motionNavigationTransitionType = .autoReverse(presenting: .zoom)
    }
}


