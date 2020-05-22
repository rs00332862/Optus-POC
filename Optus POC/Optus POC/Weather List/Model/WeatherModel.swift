//
//  WeatherModel.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class CityWeatherDataModel: Decodable {
    
    let completeList: [WeatherModel]
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case completeList = "list"
        case count = "cnt"
    }
    
}

class WeatherModel: Decodable {

    var id: Int
    var visibility: Int32?
    var cityName: String?
    var tempInformation: TempInformation
    var weatherCondition: [WeatherCondition]
    var windInformation: WindInformation
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case visibility = "visibility"
        case cityName = "name"
        case tempInformation = "main"
        case weatherCondition = "weather"
        case windInformation = "wind"
    }
}
