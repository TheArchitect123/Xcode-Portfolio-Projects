//
//  BaseViewController.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import Motion;
import Material;
import SVProgressHUD;
import Siesta;
import Toast_Swift;
import Alamofire;
import JSONParserSwift;

class BaseViewController : UITableViewController {
    
    //The base controller needs to contain a view model, which will be used by the controller and invoke the api, relating to the user
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.white;
        
        self.isMotionEnabled = true;
        ConfigureSwipePops();
        ConfigureTableView();
    }
    
    override var prefersStatusBarHidden: Bool {
        return false;
    }
    
    fileprivate func ConfigureTableView(){
        self.tableView.backgroundColor = UIColor.white;
        self.tableView.rowHeight = 120;
        self.tableView.separatorStyle = .none;
    }
    
    func ConfigureSwipePops(){

    }
    
    @objc func PopCurrentPage() {
        self.PopPage();
    }
    
    public override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
    }
}
