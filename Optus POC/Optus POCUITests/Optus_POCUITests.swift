//
//  Optus_POCUITests.swift
//  Optus POCUITests
//
//  Created by Rohit on 5/21/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import XCTest

class Optus_POCUITests: XCTestCase {
    
    var app: XCUIApplication!
    override func setUpWithError() throws {
        
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testToCheckWeatherListHasCell() {

        let weatherTableView = app.tables.matching(identifier: "Table-WeatherListTableView")
        let firstCell = weatherTableView.cells.element(matching: .cell, identifier: "weatherListCell_0")
        let existencePredicate = NSPredicate(format: "exists == 1")
        let expectationEval = expectation(for: existencePredicate, evaluatedWith: firstCell, handler: nil)
        let mobWaiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == mobWaiter, "Test Case Failed.")
    }
    func testForWeatherListCellSelection() {
        
        let weatherTableView = app.tables.matching(identifier: "Table-WeatherListTableView")
        let firstCell = weatherTableView.cells.element(matching: .cell, identifier: "weatherListCell_0")
        let predicate = NSPredicate(format: "isHittable == true")
        let expectationEval = expectation(for: predicate, evaluatedWith: firstCell, handler: nil)
        let waiter = XCTWaiter.wait(for: [expectationEval], timeout: 10.0)
        XCTAssert(XCTWaiter.Result.completed == waiter, "Test Case Failed.")
        firstCell.tap()
    }
    
    func testCitySearchTextField() {
        app.navigationBars["Weather App"].buttons["Add"].tap()
        let searchForCitySearchField = app.tables["Empty list"].searchFields["Search For City"]
        searchForCitySearchField.tap()
        app.tables["Empty list"].searchFields["Search For City"].typeText("Pune")
        guard let cityName = searchForCitySearchField.value as? String else {
            XCTFail("Invalid city name.")
            return
        }
        XCTAssertTrue(cityName == "Pune", "Incorrect entry for city name")
    }
    
    func testCitySearchTableView() {
    
    }
}
