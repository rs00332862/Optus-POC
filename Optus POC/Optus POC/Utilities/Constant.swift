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
    static let getWeatherListForGroupURL = baseURL+urlVersion+"group?APPID=7b8013e5f9448fe9ad83da81f05bd251&id=4163971,2147714,2174003"
    //"https://api.openweathermap.org/data/2.5/forecast/daily?id=4163971,2147714,2174003&cnt={cnt}&appid=7b8013e5f9448fe9ad83da81f05bd251"
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
