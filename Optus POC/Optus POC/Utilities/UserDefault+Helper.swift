//
//  UserDefault+Helper.swift
//  Optus POC
//
//  Created by Rohit on 5/24/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

class UserDefaultHelper {
    
    //one time setup for initial cities
    
    static func saveDefaultCities(){
        let userDefaults = UserDefaults.standard
        if (userDefaults.value(forKey: "InitialLoad") != nil) {
            print("This is not a first time load")
        } else {
            UserDefaults.standard.set(true, forKey: "InitialLoad")
            UserDefaults.standard.set("4163971,2147714,2174003", forKey: "CityData")
        }
    }
    
    static func saveSeclectedCityObject(cityData: CityModel,completion: () -> ()){
        var savedCityData = getAllSecletdCitieIDs()
        if savedCityData != "" {
            savedCityData += ","
        }
        savedCityData += String(cityData.cityID)
        UserDefaults.standard.set(savedCityData, forKey: "CityData")
        completion()
    }
    
    static func getAllSecletdCitieIDs() -> String {
        let userDefaults = UserDefaults.standard
        if let cityData = userDefaults.value(forKey: "CityData") {
            return cityData as! String
        } else {
            return ""
        }
    }
    
    func deleteSelectedCityFromUserDefault(cityID: Int,completion: @escaping (Result<Bool, Error>) -> Void){
        
    }
}
