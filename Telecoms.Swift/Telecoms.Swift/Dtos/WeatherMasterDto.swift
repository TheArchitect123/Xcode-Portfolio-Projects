//
//  WeatherMasterDto.swift
//  Telecoms.Swift
//
//  Created by Assassin on 28/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//


import Foundation;
import MapKit;
import JSONParserSwift

class WeatherMasterDto : ParsableModel {
    var coord : CityCoordinates?;
    var weather: [WeatherResult]?;
    
    var main: TemperatureResult?;
    var visibility : Int?;
    var wind: WindResult?;
    
    var clouds: CloudsResult?;
    
    var name: String?;
    var cod: Int?;
}
