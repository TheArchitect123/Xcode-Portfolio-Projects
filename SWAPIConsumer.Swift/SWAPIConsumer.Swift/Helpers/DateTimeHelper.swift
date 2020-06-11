//
//  DateTimeHelper.swift
//  SWAPIConsumer.Swift
//
//  Created by Assassin on 10/6/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

class DateHelper{
    static func ConvertToDate(dateString: String) -> Date? {
        
        let dateFormatter = DateFormatter();
        dateFormatter.locale = Locale(identifier: "en_US_POSIX");
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ";
        if(!dateString.isEmpty){
            let date = dateFormatter.date(from:dateString);
            if(date != nil){
                let calendar = Calendar.current;
                let components = calendar.dateComponents([.year, .month, .day, .hour], from: date!);
                
                return calendar.date(from:components)!;
            }
            else {return nil;}
        }
        else {
            return nil;
        }
    }
}
