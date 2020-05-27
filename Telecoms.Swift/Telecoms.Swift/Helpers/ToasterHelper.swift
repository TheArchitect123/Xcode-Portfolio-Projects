//
//  ToasterHelper.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Toast_Swift;

class ToasterHelper {
    
    static func OpenSimpleToast(_ viewController: UIViewController, _ message: String) {
        viewController.view.hideAllToasts();
        viewController.view.makeToast(message, duration: 3.0, position: .top)
    }
    
    static func OpenSimpleToastIndefinetly(_ viewController: UIViewController, _ message: String) {
        viewController.view.hideAllToasts();
        viewController.view.makeToast(message, duration: Double.infinity, position: .top)
    }
    
    static func HideAllToasts(_ viewController: UIViewController) {
        viewController.view.hideAllToasts();
    }
}
