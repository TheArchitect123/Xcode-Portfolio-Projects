//
//  VehiclesResultDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class VehiclesResultDto : ParsableModel {
    var name : String = "";
    var model : String = "";
    var manufacturer : String = "";
    var cost_in_credits : String = "";
    var length : Double = 0;
    var max_atmosphering_speed : Int = 0;
    var crew : Int = 0
    var passengers : Int = 0;
    var cargo_capacity : Double = 0;
    
    var consumables: String = "";
    var vehicle_class : String = "";
    
    //Collections
    var pilots : Array<String>?;
    var films : Array<String>?;
    
    var created : String = "";
    var edited : String = "";
    var url: String = "";
}
