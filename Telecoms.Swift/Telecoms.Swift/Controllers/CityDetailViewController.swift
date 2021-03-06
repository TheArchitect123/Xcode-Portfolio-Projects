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
import DrawerKit;

class CityDetailViewController : UIViewController, DrawerCoordinating {
    var drawerDisplayController: DrawerDisplayController?
    var drawerController : CityDetailsBottomDrawerController?;
    
    var CityID : Int?;
    var CityLocation: CLLocationCoordinate2D?;
    var CityName : String?;
    
    @IBOutlet var _centralisedMap: MKMapView!
    @IBOutlet var _viewTempDetails: UIButton!
    
    //    var _dropDownView : DropDown?;
    //    var _masterScroll : UIScrollView?
    //    var DataSource :  DashboardWeatherSource?;
    
    public override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        
        SetupNavigationBar();
        SetupOtherUIComponents();
        SetupDataSource();
        ConfigureBottomDrawer();
    }
    
    func ConfigureBottomDrawer() {
        drawerController = storyboard?.instantiateViewController(withIdentifier: "CityDetailsBottomDrawerController")
            as? CityDetailsBottomDrawerController;
        
        print(CityID!);
        drawerController!.CityId = CityID!;
        // you can provide the configuration values in the initialiser...
        var configuration = DrawerConfiguration(/* ..., ..., ..., */)
        //configuration.totalDurationInSeconds = 3 // default is 0.4
        configuration.durationIsProportionalToDistanceTraveled = false;
        
        // default is UISpringTimingParameters()
        configuration.timingCurveProvider = UISpringTimingParameters(dampingRatio: 0.8);
        configuration.fullExpansionBehaviour = .leavesCustomGap(gap: 100);
        configuration.supportsPartialExpansion = true;
        configuration.dismissesInStages = true;
        configuration.isDrawerDraggable = true;
        configuration.isFullyPresentableByDrawerTaps = true;
        configuration.numberOfTapsForFullDrawerPresentation = 1;
        configuration.isDismissableByOutsideDrawerTaps = true;
        configuration.numberOfTapsForOutsideDrawerDismissal = 1;
        configuration.flickSpeedThreshold = 3;
        configuration.upperMarkGap = 100; // default is 40
        configuration.lowerMarkGap =  80; // default is 40
        configuration.maximumCornerRadius = 15;
        
        var handleViewConfiguration = HandleViewConfiguration();
        handleViewConfiguration.autoAnimatesDimming = true;
        handleViewConfiguration.backgroundColor = .gray;
        handleViewConfiguration.size = CGSize(width: 40, height: 6);
        handleViewConfiguration.top = 20;
        handleViewConfiguration.cornerRadius = .automatic;
        configuration.handleViewConfiguration = handleViewConfiguration;
        
        let borderColor = UIColor.black;
        let drawerBorderConfiguration = DrawerBorderConfiguration(borderThickness: 0.5,
                                                                  borderColor: borderColor);
        configuration.drawerBorderConfiguration = drawerBorderConfiguration;
        
        let drawerShadowConfiguration = DrawerShadowConfiguration(shadowOpacity: 0.25,
                                                                  shadowRadius: 4,
                                                                  shadowOffset: .zero,
                                                                  shadowColor: .black);
        configuration.drawerShadowConfiguration = drawerShadowConfiguration;
        
        drawerDisplayController = DrawerDisplayController(presentingViewController: self,
                                                          presentedViewController: drawerController!,
                                                          configuration: configuration,
                                                          inDebugMode: false);
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        LoadInitialMapLocation();
        
        self.ForceOrientation(orientation: UIInterfaceOrientation.portrait);
        self.lockOrientation(.portrait);
    }
    
    // MARK: Maps setup
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
        OpenTemperatureDetails();
    }
    
    fileprivate func SetupDataSource() {
        //  self.DataSource = DashboardWeatherSource.init();
        //  self.tableView!.dataSource = self.DataSource;
        //   self.tableView!.delegate = self.DataSource;
        
    }
    
    fileprivate func SetupOtherUIComponents(){
        self._viewTempDetails.addTarget(self, action: #selector(OpenTemperatureDetails), for: UIControl.Event.touchDown);
        self._viewTempDetails.layer.cornerRadius = 10;
        
    }
    
    @objc fileprivate func ClosePage(){
        
        if(drawerController!.isBeingPresented){
            drawerController!.dismiss(animated: true, completion: { () -> Void in
                self.DismissPage();
            });
        }
        else {
            self.DismissPage();
        }
    }
    
    override var shouldAutorotate: Bool {
        return true;
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait;
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait;
    }
    
    fileprivate func DismissPage(){
        self.PopPage();
        self.lockOrientation(.all);
    }
    
    @objc fileprivate func OpenTemperatureDetails(){
        
        self.present(drawerController!, animated: true, completion:{() -> Void in
            print ("Test");
        })
    }
    
    fileprivate func SetupNavigationBar(){
        //Navigation Bar Setup
        self.navigationItem.setLeftBarButton(UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(ClosePage)), animated: false);
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
