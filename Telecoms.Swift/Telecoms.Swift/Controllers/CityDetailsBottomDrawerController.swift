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
import URWeatherView;

class CityDetailsBottomDrawerController : BottomController, DrawerPresentable {
    var heightOfPartiallyExpandedDrawer: CGFloat {
        return 100;
    }
    
    var CityId: Int?;
    
    //Weather Simulation
    var weatherSimulatorView: URWeatherView?
    
    @IBOutlet var _cityScrollMngr: UIScrollView!
    @IBOutlet var _cityTemperatureDescription: UILabel!
    @IBOutlet var _cityCurrentTemperature: UILabel!
    @IBOutlet var _cityTitle: UILabel!
    public override func viewDidLoad() {
        
        // self.startingHeight = 50;
        //        self.heightOfPartiallyExpandedDrawer = 200;
        //self.cornerRadius = 20;
        ConfigureDrawer();
        SetupOtherUIComponents();
        RefreshItems();
        ConfigureWeatherPreview();
    }
    
    fileprivate func ConfigureDrawer()
    {
        self.startingHeight = 50;
        self.cornerRadius = 10;
        self.roundedCorner = true;
        self.ForceOrientation(orientation: UIInterfaceOrientation.portrait);
    }
    
    fileprivate func SetupOtherUIComponents(){
        let masterRefreshMngr = UIRefreshControl.init();
        masterRefreshMngr.addTarget(self, action: #selector(RefreshItems), for: UIControl.Event.valueChanged);
        
        self._cityScrollMngr.refreshControl = masterRefreshMngr;
        self._cityScrollMngr.backgroundColor = UIColor.clear;
    }
    
    fileprivate func ConfigureWeatherPreview(){
        
        self.weatherSimulatorView = URWeatherView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height), mainWeatherImage: UIImage.init(named: "rain_bg.jpg")!, backgroundImage: nil);
        
        
        //self.weatherSimulatorView?.birthRate = 0.5;
        self.weatherSimulatorView!.startWeatherSceneBulk(.rain, debugOption: false, additionalTask: {
                   
        });
        
        self.view.addSubview(self.weatherSimulatorView!);
        self.view.sendSubviewToBack(self.weatherSimulatorView!);
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        return UIInterfaceOrientation.portrait;
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait;
    }
    
    // MARK: Processors from the ViewModel -- Passing Data to the Data Source
    internal func ReturnedCities(_ items: inout [WeatherMaster]) {
        
        //Bind the information into the outlets
        _cityTemperatureDescription.text = FriendlyNames.WeatherDescription_ByIcon(weather: FriendlyNames.GetWeatherTyp_ForName(items[0].weather[0].main), maxTemp: Int(items[0].main.temp_max), currentTemp: Int(items[0].main.temp));
        
        _cityTitle.text = items[0].name;
        _cityCurrentTemperature.text = "\(Int(items[0].main.temp))º";
        
        let tableDetails = self.children[0] as! CityDetailEmbeddedViewController;
        tableDetails._currentAtmosp.text = "\(items[0].main.pressure)hPa";
        tableDetails._sunsetTemp.text = "\(Int(items[0].main.temp_max))º";
        tableDetails._sunriseTemp.text = "\(Int(items[0].main.temp_min))º";
        tableDetails._currentTemp.text = "\(Int(items[0].main.temp))º";
        tableDetails._currentFeelsLike.text = "\(Int(items[0].main.feels_like))º";
        
        tableDetails._currentVisibility.text = "\(Int(items[0].visibility / 1000))km";
        
        tableDetails._currentWind.text = "\(items[0].wind.speed)m/s";
        tableDetails._currentHumidity.text = "\(items[0].main.humidity)%";
        
        let anyClouds : Bool = FriendlyNames.GetWeatherTyp_ForName(items[0].weather[0].main) != .Clear;
        tableDetails._currentCloud.text = "\(anyClouds ? "Yes" : "No")";
        
        self._cityScrollMngr.refreshControl?.endRefreshing();
    }
    
    @objc func RefreshItems() {
        CityDetailsBottomDrawerViewModel.GetCityResults_ByCities(self, "\(CityId!)");
    }
}
