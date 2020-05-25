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
    
    /// set weather data on colection view cell
    func setDailyWeatherCellData() {
        let dailtDataObject = weeklyWeatherViewModel.getWeeklyDataObjectFor(indexPathRow: self.tag)
        minAndMaxWeatherLabel.text =  Constant.convertTempFromKelvinToCelcius(kelvinTemprecture: dailtDataObject.tempInformation.temp)
        let weatherImgageIconName = dailtDataObject.weatherCondition.first!.weatherImage
        let weatherImageURL = Constant.weatherImageURL+weatherImgageIconName+"@2x.png"
        dailyWeatherImageView.loadImageFromURL(weatherImageURL, placeHolder: UIImage.init(named: "weatherPlaceHolder"))
        weatherDateLabel.text = converDateFrom(timestamp: dailtDataObject.weatherDate)
    }
    
    /// convert date from timestamp to to hours format
    ///
    /// - Parameter timestamp: timestamp received from service
    func converDateFrom(timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh a"
        return dateFormatter.string(from: date)
    }
}
