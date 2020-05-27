//
//  WeatherDataViewModel.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class WeatherDataViewModel {
    static var weatherListArray: [WeatherModel] = [WeatherModel]()
    var weatherListCount: Int = 0
    
    /// Method to initiate web service call to retrive weather data for saved cities
    ///
    /// - Parameter completion: completion handlor to manage and return response from service
    func getWeatherForCitiesList(completion: @escaping (Result<Bool, Error>) -> Void) {
        var urlString = Constant.getWeatherListForGroupURL
        let selectedCityIDs = UserDefaultHelper.getAllSecletdCitieIDs()
        if (selectedCityIDs != "") {
            urlString = urlString + selectedCityIDs
        }
        NetworkManager.sharedInstance.getDataFromWebService(urlString: urlString){ (responseData: Result<CityWeatherDataModel,Error>) in
            DispatchQueue.main.async {
                switch(responseData) {
                case .success(let responseWeatherList):
                    WeatherDataViewModel.self.weatherListArray = responseWeatherList.completeList
                    self.weatherListCount = responseWeatherList.count
                    //print(self.weatherListArray)
                    completion(.success(true))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    /// Method to read weather data for provided index
    ///
    /// - Parameter indexPathRow: index path which will be use to retrive data from view model
    func getWeatherDataFor(indexPathRow: Int) -> WeatherModel {
        return WeatherDataViewModel.self.weatherListArray[indexPathRow]
    }
    
    /// Method to get city name for provided index
    ///
    /// - Parameter indexPathRow: index path which will be use to retrive data from view model
    static func getCityNameFor(indexPathRow: Int) -> String {
        return WeatherDataViewModel.self.weatherListArray[indexPathRow].cityName!
    }
    
    /// Method to get city ID for provided index
    ///
    /// - Parameter indexPathRow: index path which will be use to retrive data from view model
    static func getCityIDFor(indexPathRow: Int) -> Int {
        return WeatherDataViewModel.self.weatherListArray[indexPathRow].id
    }
    
    /// Method to get background image for wether detail screen
    ///
    /// - Parameter indexPathRow: index path which will be use to retrive data from view model
    static func getBackgroundImage(indexPathRow: Int) -> String {
        let weatherImage = Constant.converDateFrom(timestamp: WeatherDataViewModel.self.weatherListArray[indexPathRow].dateTimeStamp, and: WeatherDataViewModel.self.weatherListArray[indexPathRow].sys.timezone) 
        return weatherImage
    }
}
