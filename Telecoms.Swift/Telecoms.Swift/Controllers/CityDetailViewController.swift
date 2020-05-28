//
//  CityDetailViewController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import CoreGraphics;
import SVProgressHUD;
import Material;
import Motion;
import NavigationDropdownMenu
import Toast_Swift;
import SwiftTimer;
import Siesta;
import DropDown;
import SwiftPopup
import BottomDrawer;
import MapKit;
import CoreLocation;

class CityDetailViewController : UIViewController {
    var CityID : Int?;
    var CityLocation: CLLocationCoordinate2D?;
    var CityName : String?;
    
    @IBOutlet var _centralisedMap: MKMapView!
    @IBOutlet var _closeBtn: UIButton!
    
    //    var _dropDownView : DropDown?;
    //    var _masterScroll : UIScrollView?
    //    var DataSource :  DashboardWeatherSource?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.backgroundColor = UIColor.white;
        
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        LoadInitialMapLocation();
    }
    
    fileprivate func LoadInitialMapLocation(){
        let mapCamera : MKMapCamera = MKMapCamera.init(lookingAtCenter: CityLocation!, fromEyeCoordinate: CityLocation!, eyeAltitude: 1000);
        
        self._centralisedMap.setCamera(mapCamera, animated: true);
        
        //Add a new annotation of the map
        let pointerAnnotation = MKPointAnnotation();
        pointerAnnotation.title = "\(CityName!)";
        pointerAnnotation.coordinate = CityLocation!;
        self._centralisedMap.addAnnotation(pointerAnnotation);
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        let request = self.storyboard?.instantiateViewController(withIdentifier: "CityDetailsBottomDrawerController") as? CityDetailsBottomDrawerController
        
        self.present(request!, animated: true, completion:{() -> Void in
            print ("Test");
        })
    }
    
    fileprivate func SetupDataSource() {
        //  self.DataSource = DashboardWeatherSource.init();
        //  self.tableView!.dataSource = self.DataSource;
        //   self.tableView!.delegate = self.DataSource;
    }
    
    fileprivate func SetupOtherUIComponents(){
        let masterRefreshMngr = UIRefreshControl.init();
        masterRefreshMngr.addTarget(self, action: #selector(RefreshItems), for: UIControl.Event.valueChanged);
        
        self._closeBtn.addTarget(self, action: #selector(ClosePage), for: UIControl.Event.touchDown);
    }
    
    @objc fileprivate func ClosePage(){
        self.PopPage();
    }
    
    fileprivate func SetupNavigationBar(){
        
        //self.navigationItem.titleView = _menuView!;
        self.navigationItem.setRightBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(OpenMenuDrawer)), animated: true);
        
        
        // self.view!.addSubview(navigationBar!);
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        
        //Hide the dropdown everytime the user navigates to another page
        //    _dropDownView!.hide()
    }
    
    @objc fileprivate func OpenMenuDrawer(){
        //    _dropDownView!.show()
    }
    
    
    // MARK: Processors from the ViewModel -- Passing Data to the Data Source
    @objc func RefreshItems() {
        LoaderHelper.ShowLoaderWithMessage("Synchronising");
    }
}
