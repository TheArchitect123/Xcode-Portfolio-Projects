//
//  CityDetailsBottomDrawerController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 29/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import BottomDrawer;
import DrawerKit;

class CityDetailsBottomDrawerController : BottomController, DrawerPresentable {
    var heightOfPartiallyExpandedDrawer: CGFloat = 0.0
    
    public override func viewDidLoad() {
        
        self.startingHeight = 50;
//        self.heightOfPartiallyExpandedDrawer = 200;
        //self.cornerRadius = 20;
        
    }
}
