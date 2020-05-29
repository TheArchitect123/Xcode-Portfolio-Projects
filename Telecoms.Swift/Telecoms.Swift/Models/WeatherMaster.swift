//
//  WeatherLocations.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import CoreData;
import MapKit;
import JSONParserSwift

class WeatherMaster : ParsableModel {
    var coord : CityCoordinates = CityCoordinates.init(dictionary: ["":""]);
    var weather: Array<WeatherResult> = Array<WeatherResult>.init();
    
    var main: TemperatureResult = TemperatureResult.init(dictionary: ["":""]);
    var visibility : Int = 0;
    var wind: WindResult = WindResult.init(dictionary: ["":""]);
    
    var clouds: CloudsResult = CloudsResult.init(dictionary: ["":""]);
    
    var name: String = "";
    var cod: Int = 0;
    var timezone : Double = 0;
    var sys: SysResult = SysResult.init();
    var id: Int = 0;
    
    //Database specific attributes
    var existsOnDatabase: Bool = false; //will be used by the data sources to determine whether the user is allowed to add the city to their dashboard
}
