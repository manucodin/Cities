//
//  GetCitiesUseCaseTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest

final class GetCitiesUseCaseTests: XCTestCase {
    private var sut: GetCitiesUseCase!
    private var dataSourceMock: CityDataSourceMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = CityDataSourceMock()
        sut = GetCitiesUseCase(dataSource: dataSourceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        dataSourceMock = nil
        sut = nil
    }
    
    func testGetCities() async throws {
        // Given
        let cities: [City] = [
            .makeDummy(country: "ES", name: "Madrid", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "ES", name: "Barcelona", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "ES", name: "Sevilla", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        dataSourceMock.result = .success(cities)
        
        // When
        let result = try await sut.getCities()
        
        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, cities.count)
    }
    
    func testFilterSortOrderCityThenCountry() async throws {
        // Given
        let cities: [City] = [
            .makeDummy(country: "AU", name: "Sydney", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Denver", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Albuquerque", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        dataSourceMock.result = .success(cities)

        // When
        let result = try await sut.getCities()

        // Then
        XCTAssertEqual(result.map { "\($0.name),\($0.country)" }, [
            "Albuquerque,US",
            "Denver,US",
            "Sydney,AU"
        ])
    }
}
