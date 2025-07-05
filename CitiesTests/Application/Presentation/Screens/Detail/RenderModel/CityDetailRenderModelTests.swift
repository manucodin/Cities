//
//  CityDetailRenderModelTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import XCTest
import CoreLocation

final class CityDetailRenderModelTests: XCTestCase {
    private var sut: CityDetailRenderModel!
    
    func testCorrectFlagEmoji() {
        let city = CityDetailRenderModel(
            id: 1,
            name: "Paris",
            country: "FR",
            coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            isFavorite: false,
            tempMin: 10.0,
            tempMax: 20.0,
            weatherIcon: "01d"
        )
        XCTAssertEqual(city.countryFlag, "🇫🇷")
    }
    
    func testCountryFlagIsCaseInsensitive() {
        let city = CityDetailRenderModel(
            id: 2,
            name: "Tokyo",
            country: "jp",
            coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            isFavorite: false,
            tempMin: 10.0,
            tempMax: 20.0,
            weatherIcon: "01d"
        )
        XCTAssertEqual(city.countryFlag, "🇯🇵")
    }
    
    func testCountryFlagWithInvalidCode() {
        let city = CityDetailRenderModel(
            id: 3,
            name: "Atlantis",
            country: "",
            coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            isFavorite: false,
            tempMin: 10.0,
            tempMax: 20.0,
            weatherIcon: "01d"
        )
        XCTAssertEqual(city.countryFlag, "")
    }
    
    func testCountryValidWeatherIconURL() {
        let city = CityDetailRenderModel(
            id: 3,
            name: "Atlantis",
            country: "",
            coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            isFavorite: false,
            tempMin: 10.0,
            tempMax: 20.0,
            weatherIcon: "01d"
        )
        XCTAssertNotNil(city.weatherIconURL)
        XCTAssertEqual(city.weatherIconURL?.absoluteString, "https://openweathermap.org/img/wn/01d@2x.png")
    }
}
