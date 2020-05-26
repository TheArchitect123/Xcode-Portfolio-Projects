//
//  AccountInfo.swift
//  TongueTwister.Swift
//
//  Created by Assassin on 23/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation
import UIKit;

public struct AccountInfo {
    public var Id : Int = 0;
    public var Username : String = "";
    public var Password : String = "";
    public var Creation : NSDate = NSDate.now as NSDate;
}
