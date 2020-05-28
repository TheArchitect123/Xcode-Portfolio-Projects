//
//  Date.swift
//  Telecoms.Swift
//
//  Created by Assassin on 28/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

extension Date {
    
    func GetCurrentTime(date: Date) -> (Int, Int) {
        return (Calendar.current.component(.hour, from: date), Calendar.current.component(.minute, from: date));
    }
}
