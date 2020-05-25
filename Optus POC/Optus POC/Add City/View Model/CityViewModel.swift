//
//  CityViewModel.swift
//  Optus POC
//
//  Created by Rohit on 5/24/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
class CityViewModel {
    static var completeCityList: [CityModel] = [CityModel]()
    var filteredCityList: [CityModel] = [CityModel]()
    
    static func readCityDataFromJSON(completion: @escaping (Result<Bool, Error>) -> Void) {
        if let path = Bundle.main.path(forResource: "CityList", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                do {
                    let cityData = try decoder.decode([CityModel].self, from: data)
                    CityViewModel.self.completeCityList = cityData
                    //print("Success")
                    completion(.success(true))
                } catch {
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func filterCityDataWith(string: String,completion: @escaping () -> ()) {
        filteredCityList = CityViewModel.completeCityList.filter { (city: CityModel) -> Bool in
            return city.cityName.lowercased().contains(string.lowercased())
        }
        completion()
    }
    
    static func getCityDataCount() -> Int {
        return CityViewModel.completeCityList.count
    }
}
