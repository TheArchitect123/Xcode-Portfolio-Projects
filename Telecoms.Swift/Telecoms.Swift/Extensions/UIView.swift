//
//  UIView.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import Toast_Swift;

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    public func ScreenWidth() -> Double { return Double(UIScreen.main.bounds.width);}
    public func ScreenHeight() -> Double { return Double(UIScreen.main.bounds.height);}
    
    public func GetMaxYCoordinate(_ view : UIView) -> Double {
        return Double((view.frame.origin.y + view.frame.size.height));
    }
    public func GetMaxXCoordinate(_ view: UIView) -> Double {
        return Double((view.frame.origin.y + view.frame.size.height));
    }
}

