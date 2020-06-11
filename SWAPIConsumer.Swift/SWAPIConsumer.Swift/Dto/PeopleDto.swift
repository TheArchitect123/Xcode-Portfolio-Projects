//
//  PeopleDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class PeopleDto : ParsableModel {
    var results : Array<PeopleResultDto>?;
    var count : Int = 0;
}
