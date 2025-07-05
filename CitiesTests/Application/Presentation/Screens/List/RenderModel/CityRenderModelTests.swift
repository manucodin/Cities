//
//  CityRenderModelTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest
import CoreLocation

final class CityRenderModelTests: XCTestCase {
    private var sut: CityRenderModel!
    
    func testCorrectFlagEmoji() {
        let city = CityRenderModel(id: 1, name: "Paris", country: "FR", coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0), isFavorite: false)
        XCTAssertEqual(city.countryFlag, "🇫🇷")
    }
    
    func testCountryFlagIsCaseInsensitive() {
        let city = CityRenderModel(id: 2, name: "Tokyo", country: "jp", coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0), isFavorite: false)
        XCTAssertEqual(city.countryFlag, "🇯🇵")
    }
    
    func testCountryFlagWithInvalidCode() {
        let city = CityRenderModel(id: 3, name: "Atlantis", country: "", coordinates: CLLocationCoordinate2D(latitude: 0, longitude: 0), isFavorite: false)
        XCTAssertEqual(city.countryFlag, "")
    }
}
