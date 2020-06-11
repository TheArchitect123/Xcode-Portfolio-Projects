//
//  DashboardController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import UIKit;

//Material Components
import MaterialComponents;

class DashboardController : BaseViewController{
    
    //Widgets
    var _floatingBtn : MDCFloatingButton?
    lazy var ViewModel : DashboardViewModel? = DashboardViewModel.init();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        setupUIComponents();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //DialogueHelper.showDialogWithSimpleMessage("MAMAHAAHA AMAMAHAH!");
    }
    
    func setupUIComponents() {
        //Add a floating button, for refresh of the query results
//        _floatingBtn = MDCFloatingButton.init(frame: CGRect.init(x: self, y: 0, width: self.view.ScreenWidth(), height: self.view.ScreenHeight()));
        
        
//        self.view.addSubview(_floatingBtn!);
    }
}
