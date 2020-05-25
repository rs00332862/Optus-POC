//
//  WeatherDetailTableViewCell.swift
//  Optus POC
//
//  Created by Rohit on 5/22/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherDetailTableViewCell: UITableViewCell {
    
    let weatherDataViewModel = WeatherDataViewModel()
    @IBOutlet weak var weatherDetailImageView: UIImageView!
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeWeatherLabel: UILabel!
    @IBOutlet weak var maximumWeatherLabel: UILabel!
    @IBOutlet weak var minimumWeatherLabel: UILabel!
    @IBOutlet weak var windSpeedWeatherLabel: UILabel!
    @IBOutlet weak var windSpeedImageView: UIImageView!
    
    func setWeatherDetailCellFor(indexPathRow: Int) {
        
        let weatherData = weatherDataViewModel.getWeatherDataFor(indexPathRow: indexPathRow)
        self.weatherTempLabel.text =  Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: weatherData.tempInformation.temp)
        let weatherImgageIconName = weatherData.weatherCondition.first!.weatherImage
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName+"@2x.png"
        self.weatherDetailImageView.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))
        animateImage()
        self.weatherDescriptionLabel.text = weatherData.weatherCondition.first!.description
        self.feelsLikeWeatherLabel.text = NSLocalizedString("FeelsLike", comment: "") + Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: weatherData.tempInformation.feelsLikeTemp)
        self.maximumWeatherLabel.text = "↑" + Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: weatherData.tempInformation.maxTemp)
        self.minimumWeatherLabel.text = "↓" +  Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: weatherData.tempInformation.minTemp)
        self.windSpeedWeatherLabel.text = String(weatherData.windInformation.windspeed) + NSLocalizedString("WindSpeedText", comment: "")
        windSpeedImageView.rotate360Degrees()
    }
    
    private func animateImage() {
        let options: UIView.AnimationOptions = [.curveEaseInOut,
                                                .repeat,
                                                .autoreverse]
        UIView.animate(withDuration: 3,
                       delay: 0.3,
                       options: options,
                       animations: { [weak self] in
                        self?.weatherDetailImageView.frame.size.height *= 1.3
                        self?.weatherDetailImageView.frame.size.width *= 1.3
            }, completion: nil)
    }
}
