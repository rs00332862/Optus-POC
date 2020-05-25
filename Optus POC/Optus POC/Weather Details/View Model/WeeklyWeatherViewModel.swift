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
    
    /// method to initiate webservice call  to retrive next 24 hours data
    ///
    /// - Parameter selectedCellIndex: will be used to rerive city ID wchich will be passsed as parameter in webservice
    func getWeeklyWeatherForCity(selectedCellIndex: Int,completion: @escaping (Result<Bool, Error>) -> Void) {
        var urlString = Constant.getWeeklyDataForCityURL
        urlString += String(WeatherDataViewModel.getCityIDFor(indexPathRow: selectedCellIndex))
        NetworkManager.sharedInstance.getDataFromWebService(urlString: urlString){ (responseData: Result<WeeklyWeatherModel,Error>) in
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
    
    /// To get count of record recived from servcie
    func getWeeklyWeatherDataCount() -> Int {
        return WeeklyWeatherViewModel.weeklyDataArray.count
    }
    
    /// method to read wetaher data for webservcie responce for provided Index Path row number
    ///
    /// - Parameter selectedCellIndex: will be used to rerive city ID wchich will be passsed as parameter in webservice
    func getWeeklyDataObjectFor(indexPathRow: Int) -> DailyWeather {
        return WeeklyWeatherViewModel.weeklyDataArray[indexPathRow]
    }
    
}
