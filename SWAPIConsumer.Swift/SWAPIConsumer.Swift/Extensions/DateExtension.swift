//
//  DateExtension.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

extension Date {
    
    func GetCurrentTime(date: Date) -> (Int, Int) {
        return (Calendar.current.component(.hour, from: date), Calendar.current.component(.minute, from: date));
    }
}
