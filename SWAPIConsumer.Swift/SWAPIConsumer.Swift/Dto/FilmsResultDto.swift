//
//  FilmsResultDto.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import JSONParserSwift;

class FilmsResultDto : ParsableModel {
    var title : String = "";
    var episode_id : Int = 0;
    var opening_crawl : String = "";
    var director : String = "";
    var producer : String = "";
    var release_date : String = "";
    
    //Collections
    var characters : Array<PeopleResultDto>?;
    var planets : Array<PlanetsResultDto>?;
    var starships : Array<StarshipsResultDto>?;
    var vehicles : Array<VehiclesResultDto>?;
    var species : Array<SpeciesResultDto>?;
    
    var created : String = "";
    var edited : String = "";
    var url: String = "";
}
