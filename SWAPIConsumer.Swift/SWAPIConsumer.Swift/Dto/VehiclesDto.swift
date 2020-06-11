//
//  VehiclesDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class VehiclesDto : ParsableModel {
    var results : Array<VehiclesResultDto>?;
    var count : Int = 0;
}
