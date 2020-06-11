//
//  Films.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 11/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation;
import CoreData;

class FilmsModel : NSManagedObject {
    var movieTitle : String = "";
    var episodeNum : Int = 0;
    var openingDesc : String = "";
    var directorName : String = "";
    var producerName : String = "";
    var releaseDate : String = "";
    
    //Collections
    @NSManaged var actors : [String]?
    
    var createdDate : String = "";
    var editedDate : String = "";
    var filmUrl: String = "";
}
