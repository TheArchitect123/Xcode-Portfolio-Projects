//
//  PeopleResultDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class PeopleResultDto : ParsableModel {
    //Single Items
    var name : String = "";
    var height : Int = 0;
    var mass : Int = 0;
    var hair_color : String = "";
    var skin_color : String = "";
    var eye_color : String = "";
    var birth_year : String = "";
    var gender : String = "";
    var homeworld : String = "";
    
    //Arrays
    var films : Array<String>?;
    var species : Array<String>?;
    var vehicles : Array<String>?;
    var starships : Array<String>?;
    var created : String = "";
    var edited : String = "";
    var url: String = "";
}
