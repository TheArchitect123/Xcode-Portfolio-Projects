//
//  CityDetailEmbeddedViewController.swift
//  Telecoms.Swift
//
//  Created by Assassin on 29/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

class CityDetailEmbeddedViewController : UITableViewController {
    @IBOutlet var _currentCloud: UILabel!
    @IBOutlet var _currentFeelsLike: UILabel!
    @IBOutlet var _currentVisibility: UILabel!
    
    @IBOutlet var _currentWind: UILabel!
    @IBOutlet var _currentAtmosp: UILabel!
    @IBOutlet var _currentHumidity: UILabel!
    
    @IBOutlet var _currentTemp: UILabel!
    @IBOutlet var _sunsetTemp: UILabel!
    @IBOutlet var _sunriseTemp: UILabel!
    
    public override func viewDidLoad() {
        
        self.view.backgroundColor = UIColor.black;
    }
}
