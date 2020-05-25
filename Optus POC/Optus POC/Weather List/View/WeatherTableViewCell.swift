//
//  WeatherTableViewCell.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    let weatherDataViewModel = WeatherDataViewModel()
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityTemperature: UILabel!
    
    /// Method to set data on weather list table view cell
    func setWeatherCellWithData() {
        let weatherData = weatherDataViewModel.getWeatherDataFor(indexPathRow: self.tag)
        cityName.text =  weatherData.cityName
        cityTemperature.text =  Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: weatherData.tempInformation.temp)
        
        let weatherImgageIconName = weatherData.weatherCondition.first!.weatherImage
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName+"@2x.png"
        //+"@2x.png"
        weatherImageView.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))
    }
    
    
    
}
