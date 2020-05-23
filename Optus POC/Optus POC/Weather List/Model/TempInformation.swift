//
//  TempInformation.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

struct TempInformation: Decodable  {
    
    var temp: Double
    var minTemp: Double
    var maxTemp: Double
    var humidity: Double
    var feelsLikeTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLikeTemp = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
        case humidity = "humidity"
    }
}

struct WindInformation: Decodable  {
    var windspeed: Double
    var degrees: Double?
    
    enum CodingKeys: String, CodingKey {
        case windspeed = "speed"
        case degrees = "deg"
    }
}

struct WeatherCondition: Decodable {
    var id: Int32
    var description: String
    var weatherImage: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case description = "description"
        case weatherImage = "icon"
    }
}
