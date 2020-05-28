//
//  WeatherResult.swift
//  Telecoms.Swift
//
//  Created by Assassin on 28/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import CoreData;
import JSONParserSwift;

class WeatherResult : ParsableModel {
    var id: Int = 0;
    var main : String = "";
    var icon : String = "";
}
