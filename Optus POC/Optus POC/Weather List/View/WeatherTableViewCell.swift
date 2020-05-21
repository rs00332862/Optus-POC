//
//  WeatherTableViewCell.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var weatherImageView: UIView!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var cityTemperature: UILabel!
}
