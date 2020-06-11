//
//  SpeciesResultDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class SpeciesResultDto : ParsableModel {

    var name : String = "";
    var classification : String = "";
    var designation : String = "";
    var average_height : Int = 0;
    var skin_colors : String = "";
    var hair_colors : String = "";
    var eye_colors : String = "";
    var average_lifespan : String = "";
    
    var homeworld : String?;
    var language : String = "";
    var people : Array<String>?;
    var films : Array<String>?;
    
    var created : String = "";
    var edited : String = "";
    var url: String = "";
}
