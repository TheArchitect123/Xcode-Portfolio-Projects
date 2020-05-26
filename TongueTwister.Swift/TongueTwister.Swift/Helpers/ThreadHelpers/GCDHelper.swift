//
//  GCDHelper.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 25/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;
import CoreFoundation;

internal class GCDHelper {
    internal static func RunOnMainThread() {
        //Forces the closure to run on the main thread
    }
    
    internal static func RunOnBackgroundThread(){
        //Instantiates a new thread via GDC (Grand Central Dispatch) and runs the closure on it
    }
}
