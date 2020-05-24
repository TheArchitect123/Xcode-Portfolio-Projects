//
//  NetworkHelpers.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

internal final class NetworkHelper{
    
    required init(){
        BeginMonitoringNetwork();
    }
    
    private func BeginMonitoringNetwork() {
        //Subscribe to any network changes here, then make sure to propogate these errors to the top
    }

    //Public Api Functions
    internal func IsServerAvailable(_ urlPath: String) -> Bool {
        
        
        return false;
    }

    
    internal func GetPhrasesForCategory(_ category: PhraseCategories) {
        //a constant api here used for getting the items from the server
        
        
    }
}
