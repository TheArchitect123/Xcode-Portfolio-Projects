//
//  NavigationBar.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;
import Material;
import Motion;
import Siesta;

internal class CustomNavigationBar : UIView {
    
    //Draw all the components here
    //Menu Item
    //Search Item
    //Back Button,
    //etc
    
    //The controllers that will use these components will bind the selectors to these views and manage the navigation
    
    internal var LeftBarButton : Button;
    //var RightBarButton : Button;
    //var TitleView : UILabel;
    
    override init(frame: CGRect) {
        LeftBarButton = Button.init(frame: CGRect(x: 20, y: Double(frame.center.y - 22.5), width: 45, height: 45))
        
        super.init(frame: frame);
        self.frame = frame;
        
        self.addSubview(LeftBarButton);
    }
    
    required init?(coder: NSCoder) {
        LeftBarButton = Button.init(coder: coder)!;
        super.init(coder: coder);
    }
}
