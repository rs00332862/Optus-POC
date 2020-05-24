//
//  Constant.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class Constant {
    static let weatherCustomCellIdentifier = "WeatherTableViewCell"
    static let baseURL = "https://api.openweathermap.org/data/"
    static let urlVersion = "2.5/"
    static let getWeatherListForGroupURL = baseURL+urlVersion+"group?APPID=4228b7f35b02f5f55940f57fadc298fb&id=4163971,2147714,2174003"
    //https://api.openweathermap.org/data/2.5/forecast/daily?id=524901&appid=7b8013e5f9448fe9ad83da81f05bd251
    //https://api.openweathermap.org/data/2.5/forecast/daily?q=Melbourne&cnt=7&appid=7b8013e5f9448fe9ad83da81f05bd251
    //https://api.openweathermap.org/data/2.5/onecall?lat=-27.47&lon=153.03&exclude=hourly,minutely&appid=4228b7f35b02f5f55940f57fadc298fb
    static let getWeeklyDataForCityURL = baseURL+urlVersion+"onecall?lat=-27.47&lon=153.03&exclude=hourly,minutely&appid=4228b7f35b02f5f55940f57fadc298fb"
    static let weatherImageURL = "http://openweathermap.org/img/wn/"
    static let weatherDetailCustomCellIdentifier = "weatherDetailCustomCell"
    
    
    static func convertTempFromKelvinToCelcius(kelvinTemprecture: Double) -> String {
        var measurement = Measurement(value: kelvinTemprecture, unit: UnitTemperature.kelvin)
        measurement.convert(to: UnitTemperature.celsius)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
       return measurementFormatter.string(from: measurement)
    }
}
