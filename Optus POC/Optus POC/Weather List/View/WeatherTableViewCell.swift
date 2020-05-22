//
//  WeatherTableViewCell.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var cityTemperature: UILabel!
    
    func setWeatherCellWith(weatherData: WeatherModel) {
        cityName.text =  weatherData.cityName
        cityTemperature.text =  convertTempFromKelvinToCelcius(kelvinTemprecture: weatherData.tempInformation.temp)
        
        let weatherImgageIconName = weatherData.weatherCondition.first!.weatherImage
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName+"@2x.png"
        //+"@2x.png"
        weatherImageView.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))
    }
    
    func convertTempFromKelvinToCelcius(kelvinTemprecture: Double) -> String {
        var measurement = Measurement(value: kelvinTemprecture, unit: UnitTemperature.kelvin)
        measurement.convert(to: UnitTemperature.celsius)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitStyle = .short
        measurementFormatter.numberFormatter.maximumFractionDigits = 0
        measurementFormatter.unitOptions = .temperatureWithoutUnit
       return measurementFormatter.string(from: measurement)
    }
    
}
