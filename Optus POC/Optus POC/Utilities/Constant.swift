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
    static let getWeeklyDataForCityURL = baseURL+urlVersion+"forecast?appid=" + valueForAPIKey(keyName:"API_CLIENT_KEY") + "&cnt=8&id="
    static let weatherImageURL = "http://openweathermap.org/img/wn/"
    static let weatherDetailCustomCellIdentifier = "weatherDetailCustomCell"
    
    
    /// Method to convert kelvin temp to desired unit format
    ///
    /// - Parameter kelvinTemprecture: Kelvin temp received from service and will be used to convert is desired format
    static func convertTempFromKelvinToCelcius(kelvinTemprecture: Double) -> String {
        var measurement = Measurement(value: kelvinTemprecture, unit: UnitTemperature.kelvin)
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .providedUnit
        if(UserDefaultHelper.getTempratureUnit() == "C"){
            measurement.convert(to: UnitTemperature.celsius)
        } else {
            measurement.convert(to: UnitTemperature.fahrenheit)
            return measurementFormatter.string(from: measurement) + "F"
        }
        return measurementFormatter.string(from: measurement)
    }
    
    /// Method to read open weather api key store in plist file
    ///
    /// - Parameter keyName: Key name which will be used to read data from plist file
    static func valueForAPIKey(keyName:String) -> String {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyName) as! String
        return value
    }
    
    /// convert date from timestamp to  hours format
    ///
    /// - Parameter timestamp: timestamp received from service
    static func converDateFrom(timestamp: Double, and timeZone: Int) -> String {
        let timestampDate = Date(timeIntervalSince1970: timestamp)
        let format = DateFormatter()
        format.timeZone = TimeZone(secondsFromGMT: timeZone)!
        format.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = format.string(from: timestampDate)
        let splitDateArray = dateString.split(separator: "T")
        let splitTimeArray = splitDateArray[1].split(separator: ":")
        let hour = Int(splitTimeArray[0])
        if hour! > 6 && hour! < 18 {
            return "Sun"
        } else {
            return "Night"
        }
        
    }
}
