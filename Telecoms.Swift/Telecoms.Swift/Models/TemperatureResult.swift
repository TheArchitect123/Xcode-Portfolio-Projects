//
//  TemperatureResults.swift
//  Telecoms.Swift
//
//  Created by Assassin on 28/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import CoreData;
import JSONParserSwift;

class TemperatureResult : ParsableModel{
    
    var temp: Double = 0;
    var feels_like: Double = 0;
    var temp_min: Double = 0;
    var temp_max: Double = 0;
    var pressure : Double = 0;
    var humidity : Double = 0;
}
