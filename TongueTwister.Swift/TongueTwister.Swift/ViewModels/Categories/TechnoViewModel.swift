//
//  TechnoViewModel.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

//These classes are individually based -- they manage the data that is associated with their page (controller)
internal final class TechnoViewModel{ //These view models cannot be inhereted
    var Items : Dictionary<String, String> = Dictionary.init(minimumCapacity: 0);

    init() {
        //Any initialization on when the controller appears
        //Make sure to lazy load as much as possible
    }
}
