//
//  RootMngrDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class RootMngrDto : ParsableModel {
    var people : PeopleDto?;
    var planets : PlanetsDto?;
    var films : FilmsDto?;
    var species : SpeciesDto?;
    var vehicles : VehiclesDto?;
    var starships : StarshipsDto?;
}
