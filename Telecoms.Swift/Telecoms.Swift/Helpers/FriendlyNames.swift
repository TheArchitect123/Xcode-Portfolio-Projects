//
//  FriendlyNames.swift
//  Telecoms.Swift
//
//  Created by Assassin on 29/5/20.
//  Copyright © 2020 Dan Gerchcovich. All rights reserved.
//

import Foundation

class FriendlyNames {
    
    //This function will return a string for the detail page to render
    static func WeatherDescription_ByIcon(weather: WeatherTypes, maxTemp : Int, currentTemp: Int) -> String{
        switch weather {
        // MARK: Day Time Weather Scenarios
        case .Clear: //Clear Sky
            return "Today: Clear currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
        case .Clouds: //Clouds Sky
            return "Today: Cloudy currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
        case .Ash: //Ash Sky
            return "Today: Ashy currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
        case .Drizzle: //Drizzle Sky
            return "Today: Drizzly Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
        case .Dust: //Dust Sky
            return "Today: Dusty Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Fog: //Foggy Sky
            return "Today: Foggy Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Haze: //Haze Sky
            return "Today: Hazy Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Mist: //Misty Sky
            return "Today: Misty Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Rain: //Rain Sky
            return "Today: Rain Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Sand: //Sandy Sky
            return "Today: Sandy Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Smoke: //Smoke Sky
            return "Today: Smoke Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Snow: //Snow Sky
            return "Today: Snow Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Squall: //Squall Sky
            return "Today: Squally Currently. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Thunderstorm: //Thunderstorm Sky
            return "Today: There's a thunderstorm right now! Run for cover. It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
            
        case .Tornado: //Tornado Sky
            return "Today: There's a tornado right now! Run for cover. Also It's \(currentTemp)º; the maximum is forecast to be \(maxTemp)º";
        }
    }
    
    static func GetWeatherTyp_ForName(_ name: String) -> WeatherTypes {
        switch name {
        case "Clouds":
            return WeatherTypes.Clouds;
        case "Thunderstorm":
            return WeatherTypes.Thunderstorm;
        case "Drizzle":
            return WeatherTypes.Drizzle;
        case "Rain":
            return WeatherTypes.Rain;
        case "Snow":
            return WeatherTypes.Snow;
        case "Mist":
            return WeatherTypes.Mist;
        case "Smoke":
            return WeatherTypes.Smoke;
        case "Haze":
            return WeatherTypes.Haze;
        case "Fog":
            return WeatherTypes.Fog;
        case "Sand":
            return WeatherTypes.Sand;
        case "Dust":
            return WeatherTypes.Dust;
        case "Ash":
            return WeatherTypes.Ash;
        case "Squall":
            return WeatherTypes.Squall;
        case "Tornado":
            return WeatherTypes.Tornado;
        case "Clear":
            return WeatherTypes.Clear;
        default:
            return WeatherTypes.Clear;
        }
    }
}
