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
            UserDefaults.standard.set("C", forKey: "DefaultUnit")
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
    
    static func deleteSelectedCityFromUserDefault(cityID: Int,completion: () -> ()){
        var savedCityData = UserDefaultHelper.getAllSecletdCitieIDs()
        if(savedCityData.contains(String(cityID))) {
            savedCityData = savedCityData.replacingOccurrences(of: String(cityID), with: "")
            if(savedCityData.contains(String(",,"))) {
                savedCityData = savedCityData.replacingOccurrences(of: ",,", with: ",")
            }
        }
        UserDefaults.standard.set(savedCityData, forKey: "CityData")
        completion()
    }
    
    static func setTempratureUnit(unit: String){
          UserDefaults.standard.set(unit, forKey: "DefaultUnit")
    }
    
    static func getTempratureUnit() -> String{
        let defaultUnit = UserDefaults.standard
        return defaultUnit.value(forKey: "DefaultUnit") as! String
    }
}
