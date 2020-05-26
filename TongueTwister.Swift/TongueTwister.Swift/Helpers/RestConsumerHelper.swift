//
//  RestConsumerHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 26/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Siesta;

internal class RestConsumerHelper{
    public static func Get_DefaultRestConsumer() -> Service {
        return Service.init(baseURL: "\(AppInformation.UrlBase)");
    }
    
    public static func Get_DefaultRestConsumer_ForTesting() -> Service {
        return Service.init(baseURL: "\(AppInformation.UrlBase_Test)");
    }
}
