//
//  Logs.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import CoreData;
import JSONParserSwift;

class Logs : NSManagedObject {
    var Message : String?;
    var StackTrace : String?;
    var Created : Date?;
}
