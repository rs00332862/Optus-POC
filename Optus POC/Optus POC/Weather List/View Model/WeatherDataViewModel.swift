//
//  WeatherDataViewModel.swift
//  Optus POC
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation

class WeatherDataViewModel {
    var weatherListArray: [WeatherModel] = [WeatherModel]()
    var weatherListCount: Int = 0
    
    func getWeatherForCitiesList(completion: @escaping (Result<Bool, Error>) -> Void) {
           
        NetworkManager.sharedInstance.getDataFromWebService(urlString: Constant.getWeatherListForGroupURL){ (responseData: Result<CityWeatherDataModel,Error>) in
               DispatchQueue.main.async {
                   switch(responseData) {
                   case .success(let responseWeatherList):
                        self.weatherListArray = responseWeatherList.completeList
                        self.weatherListCount = responseWeatherList.count
                        //print(self.weatherListArray)
                       completion(.success(true))
                   case.failure(let error):
                       completion(.failure(error))
                   }
               }
           }
       }
}
