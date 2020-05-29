//
//  UIViewController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import TopViewControllerDetection;

@objc extension UIViewController {
    
    func PopPage() {
        UIApplication.shared.findTopViewController()?.navigationController?.popViewController(animated: true);
    }
    
    func PopModalPage(action: (() -> Void)? = nil) {
        UIApplication.shared.findTopViewController()?.dismiss(animated: true, completion:{ (action ?? nil);
        });
    }
    
    func NavigateToPage(_ controller : UIViewController) {
        UIApplication.shared.findTopViewController()?.navigationController?.pushViewController(controller, animated: true);
    }
    
    func NavigateToModalPage(_ controller : UIViewController, action: (() -> Void)? = nil) {
        
        UIApplication.shared.findTopViewController()!.present(controller, animated: true, completion: nil);
    }
    
    
     func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    func ForceOrientation(orientation: UIInterfaceOrientation){
        let value = orientation.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
     func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
