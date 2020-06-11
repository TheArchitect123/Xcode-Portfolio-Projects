//
//  PlanetsResultDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class PlanetsResultDto : ParsableModel {
    var name : String = "";
    var rotation_period : Int = 0;
    var orbital_period : Int = 0;
    var diameter : Int = 0;
    var climate : Int = 0;
    var gravity : Int = 0;
    var terrain : String = "";
    var surface_water : Int = 0;
    var population : Int = 0;
    
    var residents : Array<PeopleResultDto>?;
    var films : Array<FilmsResultDto>?;
    
    var created : String = "";
    var edited : String = "";
    var url: String = "";
}
