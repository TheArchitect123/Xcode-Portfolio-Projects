//
//  PlanetsDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class PlanetsDto : ParsableModel {
    var results : Array<PlanetsResultDto>?;
    var count : Int = 0;
}
