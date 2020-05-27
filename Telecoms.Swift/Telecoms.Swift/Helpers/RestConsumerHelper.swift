//
//  RestConsumerHelper.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Siesta;

class RestConsumerHelper{
    //Apis for accessing the weather service
    
   static func Get_DefaultRestConsumer() -> Service {
        return Service.init(baseURL: "\(AppInformation.UrlBase)");
    }
    
   static func Get_DefaultRestConsumer_ForTesting() -> Service {
        return Service.init(baseURL: "\(AppInformation.UrlBase_Test)");
    }
}
