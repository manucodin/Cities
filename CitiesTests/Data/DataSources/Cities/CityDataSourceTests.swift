//
//  CityDataSourceTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import XCTest

final class CityDataSourceTests: XCTestCase {
    private var sut: CityDataSource!
    private var serviceMock: CityServiceMock!
    
    override func setUp() {
        super.setUp()
        serviceMock = CityServiceMock()
        sut = CityDataSource(cityService: serviceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        serviceMock = nil
        sut = nil
    }
    
    func testFetchCities() async throws {
        // Given
        let citiesDTOs: [CityDTO] = [
            .makeDummy(country: "ES", name: "Madrid", id: 1, coordinates: .makeDummy(lat: 0, lon: 0)),
            .makeDummy(country: "ES", name: "Barcelona", id: 2, coordinates: .makeDummy(lat: 0, lon: 0)),
            .makeDummy(country: "ES", name: "Sevilla", id: 3, coordinates: .makeDummy(lat: 0, lon: 0)),
            .makeDummy(country: "ES", name: "Gijón", id: 4, coordinates: .makeDummy(lat: 0, lon: 0))
        ]
        serviceMock.result = .success(citiesDTOs)
        
        // When
        let result = try await sut.fetchCities()
        
        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, citiesDTOs.count)
        XCTAssertEqual(result.map{ $0.id }, citiesDTOs.map{ $0.id })
    }
    
    func testFetchInvalidCities() async throws {
        // Given
        let citiesDTOs: [CityDTO] = [
            .makeDummy(country: nil, name: "Madrid", id: 1, coordinates: .makeDummy(lat: 0, lon: 0)),
            .makeDummy(country: "ES", name: nil, id: 2, coordinates: .makeDummy(lat: 0, lon: 0)),
            .makeDummy(country: "ES", name: "Sevilla", id: nil, coordinates: .makeDummy(lat: 0, lon: 0)),
            .makeDummy(country: "ES", name: "Gijón", id: 4, coordinates: nil)
        ]
        serviceMock.result = .success(citiesDTOs)
        
        // When
        let result = try await sut.fetchCities()
        
        // Then
        XCTAssertTrue(result.isEmpty)
    }
}
