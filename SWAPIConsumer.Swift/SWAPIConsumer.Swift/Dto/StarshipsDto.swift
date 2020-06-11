//
//  StarshipsDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class StarshipsDto : ParsableModel {
    var results : Array<StarshipsResultDto>?;
    var count : Int = 0;
}
