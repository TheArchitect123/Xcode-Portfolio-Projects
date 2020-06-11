//
//  StarshipsResultDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class StarshipsResultDto : ParsableModel {
    var name : String = "";
    var model : String = "";
    var manufacturer : String = "";
    var cost_in_credits : String = "";
    var length : Int = 0;
    var max_atmosphering_speed : Int = 0;
    var crew : String = "";
    var passengers : Int = 0;
    var cargo_capacity : Int = 0;
    var consumables : String = "";
    
    var hyperdrive_rating : Double = 0;
    var MGLT : Int = 0;
    var starship_class : String = "";
    
    var pilots : Array<String>?;
    var films : Array<String>?;
    
    var created : String = "";
    var edited : String = "";
    var url: String = "";
}
