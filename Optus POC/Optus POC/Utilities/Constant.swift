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
    static let getWeatherListForGroupURL = baseURL+urlVersion+"group?APPID=" + valueForAPIKey(keyName:"API_CLIENT_KEY") + "&id="
    //static let getWeeklyDataForCityURL = baseURL+urlVersion+"onecall?lat=-27.47&lon=153.03&exclude=hourly,minutely&appid=4228b7f35b02f5f55940f57fadc298fb"
    static let getWeeklyDataForCityURL = baseURL+urlVersion+"forecast?appid=" + valueForAPIKey(keyName:"API_CLIENT_KEY") + "&cnt=8&id=" //4228b7f35b02f5f55940f57fadc298fb&cnt=8&id=4163971&"
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
    
    static func valueForAPIKey(keyName:String) -> String {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyName) as! String
        return value
    }
}
