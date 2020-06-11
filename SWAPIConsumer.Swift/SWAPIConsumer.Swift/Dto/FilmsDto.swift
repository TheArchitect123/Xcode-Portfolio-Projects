//
//  FilmsDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class FilmsDto : ParsableModel {
    var results : Array<FilmsResultDto>?;
    var count : Int = 0;
}
