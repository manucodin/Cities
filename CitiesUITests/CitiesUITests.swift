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
        
        let cell = app.buttons["city_list_row"]
        XCTAssertTrue(cell.waitForExistence(timeout: 5))

        let cellTitle = app.staticTexts["city_list_row_title_madrid_co"].firstMatch
        XCTAssertTrue(cellTitle.waitForExistence(timeout: 5))
    }
    
    func testMakeFavorite() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cityList = app.collectionViews["city_list"]
        XCTAssertTrue(cityList.waitForExistence(timeout: 5))
        
        let cityListRow = app.buttons["city_list_row"].firstMatch
        XCTAssertTrue(cityListRow.waitForExistence(timeout: 5))
        
        let favoriteButton = app.buttons["city_list_row_favorite_button"].firstMatch
        XCTAssertTrue(cityListRow.waitForExistence(timeout: 5))
    
        favoriteButton.tap()
        XCTAssertTrue(favoriteButton.value as? String == "On")
    }
    
    func testRemoveFavorite() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cityList = app.collectionViews["city_list"]
        XCTAssertTrue(cityList.waitForExistence(timeout: 5))
        
        let cityListRow = app.buttons["city_list_row"].firstMatch
        XCTAssertTrue(cityListRow.waitForExistence(timeout: 5))
        
        let favoriteButton = app.buttons["city_list_row_favorite_button"].firstMatch
        XCTAssertTrue(cityListRow.waitForExistence(timeout: 5))
        
        favoriteButton.tap()
        XCTAssertTrue(favoriteButton.value as? String == "Off")
    }
}
