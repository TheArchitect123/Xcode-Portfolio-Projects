//
//  RestConsumerHelper.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Siesta;

class RestConsumerHelper{
    //Apis for accessing the weather service
    
    static func Get_DefaultRestConsumer() -> Service {
        return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrl)");
    }
    
    static func Get_DefaultRestConsumerWithoutBase() -> Service{
        return Service.init();
    }
}
