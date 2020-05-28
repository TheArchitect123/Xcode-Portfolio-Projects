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
    return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrl)");
    }
    static func Get_DefaultRestConsumer_ForBulk() -> Service {
        return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrlForBulks)");
    }
    
    static func Get_DefaultRestConsumer_ForCoord() -> Service {
        return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrlForCoord)");
    }
    
    
   static func Get_DefaultRestConsumer_ForTesting() -> Service {
        return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrl_ForTesting)");
    }
}
