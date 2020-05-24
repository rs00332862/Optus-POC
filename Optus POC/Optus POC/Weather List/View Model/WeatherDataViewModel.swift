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
    
    func getWeatherDataFor(indexPathRow: Int) -> WeatherModel {
        return WeatherDataViewModel.self.weatherListArray[indexPathRow]
    }
    
    static func getCityNameFor(indexPathRow: Int) -> String {
        return WeatherDataViewModel.self.weatherListArray[indexPathRow].cityName!
    }
    
    static func getCityIDFor(indexPathRow: Int) -> Int {
        return WeatherDataViewModel.self.weatherListArray[indexPathRow].id
    }
}
