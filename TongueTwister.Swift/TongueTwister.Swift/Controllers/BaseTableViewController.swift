//
//  BaseTableViewController.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import SVProgressHUD;

internal class BaseTableViewController : UIViewController {
    internal var CustomTableView : UITableView?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.lightGray;
        self.isMotionEnabled = true;
        self.view.backgroundColor = UIColor.white;
        self.view.addGestureRecognizer(UISwipeGestureRecognizer.init(target: self, action: #selector(PopPage)));
         
        SetupUIComponents();
        SetupNavigationBar();
    }
    
    fileprivate func SetupUIComponents(){
        let masterRefreshMngr = UIRefreshControl.init();
        masterRefreshMngr.addTarget(self, action: #selector(RefreshItems), for: UIControl.Event.valueChanged);
        
        CustomTableView = UITableView.init(frame: CGRect.init(x: 0, y: 70, width: UIHelper.ScreenWidth, height: UIHelper.ScreenHeight));
        CustomTableView?.isMotionEnabled = true;
        CustomTableView?.allowsSelectionDuringEditing = true;
        CustomTableView?.rowHeight = 120;
        
        CustomTableView!.refreshControl = masterRefreshMngr;
        self.view.addSubview(CustomTableView!);
    }
    
    @objc fileprivate func PopPage(){
        self.navigationController?.popViewController(animated: true);
    }
    
    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        PopPage();
    }
    
    //Configure the Base Components 
    fileprivate func SetupNavigationBar(){
        self.navigationController!.setNavigationBarHidden(true, animated: false);
        
        let navigationBar = NavigationBarHelper.DrawNavigationBarWithBack();
        navigationBar.LeftBarButton.addTarget(self, action: #selector(PopPage), for: UIControl.Event.touchDown);
        
        self.view!.addSubview(navigationBar);
    }
    
    @objc internal func RefreshItems() {
        SVProgressHUD.show(withStatus: "Synchronising");
    }
}
