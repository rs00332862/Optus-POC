//
//  WeeklyWeatherModel.swift
//  Optus POC
//
//  Created by Rohit on 5/23/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

struct WeeklyWeatherModel: Decodable {
    var weeklyWeatherData: [DailyWeather]
    
    enum CodingKeys: String, CodingKey {
        case weeklyWeatherData = "daily"
    }
}

struct DailyWeather: Decodable {
    var weatherDate: Double
    var tempInformation: Temperature
    var weatherCondition: [WeatherCondition]
    
    enum CodingKeys: String, CodingKey {
        case weatherDate = "dt"
        case tempInformation = "temp"
        case weatherCondition = "weather"
    }
}

struct Temperature: Decodable {
    var maximumTemperature: Double
    var minimumTemperature: Double
    
    enum CodingKeys: String, CodingKey {
        case maximumTemperature = "max"
        case minimumTemperature = "min"
    }
}
