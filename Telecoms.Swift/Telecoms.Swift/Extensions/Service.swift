//
//  Service.swift
//  Telecoms.Swift
//
//  Created by Assassin on 27/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import Siesta;

extension Service {
    func Get_DefaultRestConsumer() -> Service {
        return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrl)");
    }
    
    func Get_DefaultRestConsumer_ForTesting() -> Service {
        return Service.init(baseURL: "\(UrlConstants.Remote_BaseUrl_ForTesting)");
    }
}
