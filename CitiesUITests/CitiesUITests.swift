//
//  CitiesUITests.swift
//  CitiesUITests
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import XCTest

@MainActor
final class CitiesUITests: XCTestCase {
    
    func testCityLoads() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cityList = app.collectionViews["city_list"]
        XCTAssertTrue(cityList.waitForExistence(timeout: 5))
        
        let cityListRow = app.buttons["city_list_row"].firstMatch
        XCTAssertTrue(cityListRow.waitForExistence(timeout: 5))
    }
    
    func testSearchCity() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cityList = app.collectionViews["city_list"]
        XCTAssertTrue(cityList.waitForExistence(timeout: 5))
            
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Madrid")
        
        let cell = app.buttons["city_list_row_madrid_es"]
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
}
