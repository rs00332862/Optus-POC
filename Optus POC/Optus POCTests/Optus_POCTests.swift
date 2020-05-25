//
//  Optus_POCTests.swift
//  Optus POCTests
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest
@testable import Optus_POC

class Optus_POCTests: XCTestCase {

    let weatherDataViewModel = WeatherDataViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetWeatherDataFromWebService() {
        let expectation = self.expectation(description: "Web Service response successful.")
        weatherDataViewModel.getWeatherForCitiesList { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }
}
