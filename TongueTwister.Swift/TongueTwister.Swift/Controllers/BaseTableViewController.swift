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

internal class BaseTableViewController : UITableViewController {
    
    var _navigationBar : CustomNavigationBar?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.lightGray;
        self.isMotionEnabled = true;
        self.view.backgroundColor = UIColor.white;
        self.view.addGestureRecognizer(UISwipeGestureRecognizer.init(target: self, action: #selector(PopPage)));
        
        SetupUIComponents();
        SetupNavigationBar();
    }
    
    //    func gotSilentStatus(isSilent: Bool) {
    //        if(isSilent){
    //            ToasterHelper.OpenSimpleToastIndefinetly(self, "Your phone is on silent. Please turn off silent mode in order to hear the phrases");
    //        }
    //        else {
    //            ToasterHelper.HideAllToasts(self);
    //        }
    //    }
    
    fileprivate func SetupUIComponents(){
        let masterRefreshMngr = UIRefreshControl.init();
        masterRefreshMngr.addTarget(self, action: #selector(RefreshItems), for: UIControl.Event.valueChanged);
        
        self.tableView!.isMotionEnabled = true;
        self.tableView!.allowsSelectionDuringEditing = true;
        self.tableView!.rowHeight = 90;
        
        self.tableView!.refreshControl = masterRefreshMngr;
    }
    
    @objc fileprivate func PopPage(){
        self.navigationController?.popViewController(animated: true);
    }
    
    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        PopPage();
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if(self._navigationBar != nil){
            self._navigationBar!.frame = CGRect.init(x: 0, y: 0, width: size.width, height: 70);
        }
    }
    
    //Configure the Base Components 
    fileprivate func SetupNavigationBar(){
        self.navigationController!.setNavigationBarHidden(true, animated: false);
        
        self._navigationBar = NavigationBarHelper.DrawNavigationBarWithBack();
        self._navigationBar!.frame = CGRect(x: 0,y: 0, width: self.navigationController!.navigationBar.bounds.width, height: 70);
        self._navigationBar!.LeftBarButton.addTarget(self, action: #selector(PopPage), for: UIControl.Event.touchDown);
        
        self.view!.addSubview(self._navigationBar!);
    }
    
    @objc internal func RefreshItems() {
        LoaderHelper.ShowLoaderWithMessage("Synchronising");
    }
}
