//
//  BaseViewController.swift
//  SafetyBox.Swift
//
//  Created by Assassin on 31/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

class BaseViewController : UIViewController {
    public override func viewDidLoad() {
          super.viewDidLoad();
          ConfigureMotionNavigation();
      }
      
      fileprivate func ConfigureMotionNavigation(){
          self.isMotionEnabled = true;
      }
}
