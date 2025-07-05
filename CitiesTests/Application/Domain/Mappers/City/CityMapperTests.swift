//
//  CityMapperTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import XCTest

final class CityMapperTests: XCTestCase {
    private var sut: CityMapper!
    
    override func setUp() {
        super.setUp()
        sut = CityMapper()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testMapDTO() {
        // Given
        let dto: CityDTO = .makeDummy(country: "ES", name: "Gijón", id: 1, coordinates: .makeDummy(lat: 43.53573, lon: -5.66152))
        
        // When
        let city = sut.map(dto)
        
        // Then
        XCTAssertEqual(dto.country, city?.country)
        XCTAssertEqual(dto.name, city?.name)
        XCTAssertEqual(dto.id, city?.id)
        XCTAssertEqual(dto.coordinates?.latitude, city?.coordinates.latitude)
        XCTAssertEqual(dto.coordinates?.longitude, city?.coordinates.longitude)
    }
    
    func testMapInvalidDTO() {
        // Given
        let dto: CityDTO = .makeDummy(country: "ES", name: "Gijón", id: nil, coordinates: .makeDummy(lat: 43.53573, lon: -5.66152))
        
        // When
        let city = sut.map(dto)
        
        // Then
        XCTAssertNil(city)
    }
}
