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
        case weeklyWeatherData = "list"
    }
}

struct DailyWeather: Decodable {
    var weatherDate: Double
    var tempInformation: TempInformation
    var weatherCondition: [WeatherCondition]
    var weatherTime: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDate = "dt"
        case tempInformation = "main"
        case weatherCondition = "weather"
        case weatherTime = "dt_txt"
    }
}
