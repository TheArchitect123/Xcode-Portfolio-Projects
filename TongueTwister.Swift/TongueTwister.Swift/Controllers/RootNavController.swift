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

internal class RootRootNavController : NavigationController {
 
     open override func prepare() {
       super.prepare()
        
        var controller = UIStoryboard.instantiateViewController(UIStoryboard.init(name: "Main", bundle: nil)) as! DashboardController;
        self.isMotionEnabled = true;
        self.pushViewController(controller, animated: true)
//        self.motionNavigationTransitionType = MotionTransitionAnimationType.init();
       
        //self.backgroundColor = UIColor.white;
//       v.depthPreset = .none
//       v.dividerColor = Color.grey.lighten2
     }
}

