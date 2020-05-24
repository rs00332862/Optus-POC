//
//  WeeklyWeatherViewModel.swift
//  Optus POC
//
//  Created by Rohit on 5/23/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
class WeeklyWeatherViewModel {
    static var weeklyDataArray: [DailyWeather] = [DailyWeather]()
    
    func getWeeklyWeatherForCity(completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.sharedInstance.getDataFromWebService(urlString: Constant.getWeeklyDataForCityURL){ (responseData: Result<WeeklyWeatherModel,Error>) in
            DispatchQueue.main.async {
                switch(responseData) {
                case .success(let responseWeatherList):
                    WeeklyWeatherViewModel.weeklyDataArray = responseWeatherList.weeklyWeatherData
                    print(WeeklyWeatherViewModel.weeklyDataArray)
                    completion(.success(true))
                case.failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func getWeeklyWeatherDataCount() -> Int {
        return WeeklyWeatherViewModel.weeklyDataArray.count
    }
    
    func getWeeklyDataObjectFor(indexPathRow: Int) -> DailyWeather {
        return WeeklyWeatherViewModel.weeklyDataArray[indexPathRow]
    }
    
}
