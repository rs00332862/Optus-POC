//
//  AddCity_Test.swift
//  Optus POCTests
//
//  Created by Rohit on 5/25/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest
@testable import Optus_POC

class AddCity_Test: XCTestCase {
    
    let cityViewModel = CityViewModel()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testToVerifyCityDataExist() {
        let expectation = self.expectation(description: "Application bale to load city data from local JSON.")
        CityViewModel.readCityDataFromJSON { response in
            switch(response) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 7, handler: nil)
    }
    
    func testCitySearchResultCount() {
        testToVerifyCityDataExist()
        cityViewModel.filterCityDataWith(string: "Pune") {
            XCTAssertEqual(self.cityViewModel.filteredCityList.count, 1)
        }
    }
    
    func testCitySearchZeroResult() {
        testToVerifyCityDataExist()
        cityViewModel.filterCityDataWith(string: "Rohit") {
            XCTAssertEqual(self.cityViewModel.filteredCityList.count, 0)
        }
    }
    
    func testCitySearchResultData() {
        testToVerifyCityDataExist()
        cityViewModel.filterCityDataWith(string: "Pune") {
            let firstSearchedResult = self.cityViewModel.filteredCityList[0]
            XCTAssertEqual(firstSearchedResult.cityName, "Pune")
        }
    }
}
