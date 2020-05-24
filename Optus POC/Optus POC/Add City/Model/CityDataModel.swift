//
//  CityDataModel.swift
//  Optus POC
//
//  Created by Rohit on 5/24/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

struct CityDataModel: Decodable {
    var cityDataModel: [CityModel]
}

struct CityModel: Decodable {
    var cityName: String
    var cityID: Int
    
    
    enum CodingKeys: String, CodingKey {
        case cityID = "id"
        case cityName = "name"
        
    }
}
