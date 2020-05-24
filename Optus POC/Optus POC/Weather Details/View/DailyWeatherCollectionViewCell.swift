//
//  DailyWeatherCollectionViewCell.swift
//  Optus POC
//
//  Created by Rohit on 5/23/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class DailyWeatherCollectionViewCell: UICollectionViewCell {
    
    let weeklyWeatherViewModel = WeeklyWeatherViewModel()
    @IBOutlet weak var dailyWeatherImageView: UIImageView!
    @IBOutlet weak var minAndMaxWeatherLabel: UILabel!
    @IBOutlet weak var weatherDateLabel: UILabel!
    
    func setDailyWeatherCellData() {
        let dailtDataObject = weeklyWeatherViewModel.getWeeklyDataObjectFor(indexPathRow: self.tag)
        minAndMaxWeatherLabel.text = "↑ " + Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: dailtDataObject.tempInformation.maxTemp) + "   " + "↓"
  + Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: dailtDataObject.tempInformation.minTemp)
        let weatherImgageIconName = dailtDataObject.weatherCondition.first!.weatherImage
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName+"@2x.png"
        dailyWeatherImageView.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))
        weatherDateLabel.text = converDateFrom(timestamp: dailtDataObject.weatherDate)
    }
    
    func converDateFrom(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        return dateFormatter.string(from: date)
    }
}
