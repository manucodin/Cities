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
    private var cityDataSourceMock: CityDataSourceMock!
    private var favoritesDataSourceMock: FavoritesDataSourceMock!
    
    override func setUp() {
        super.setUp()
        cityDataSourceMock = CityDataSourceMock()
        favoritesDataSourceMock = FavoritesDataSourceMock()
        sut = GetCitiesUseCase(cityDataSource: cityDataSourceMock, favoritesDataSource: favoritesDataSourceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        cityDataSourceMock = nil
        favoritesDataSourceMock = nil
        sut = nil
    }
    
    func testGetCitiesWithoutFavorites() async throws {
        // Given
        let cities: [City] = [
            .makeDummy(country: "ES", name: "Madrid", id: 1, coordinates: .init(latitude: 0, longitude: 0)),
            .makeDummy(country: "ES", name: "Barcelona", id: 2, coordinates: .init(latitude: 0, longitude: 0)),
            .makeDummy(country: "ES", name: "Sevilla", id: 3, coordinates: .init(latitude: 0, longitude: 0))
        ]
        cityDataSourceMock.result = .success(cities)
        favoritesDataSourceMock.allFavoriteIDsResult = .success([])
        
        // When
        let result = try await sut.getCities()
        
        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, cities.count)
        XCTAssertTrue(result.filter{ $0.isFavorite }.isEmpty)
    }
    
    func testGetCitiesWithFavorites() async throws {
        // Given
        let cities: [City] = [
            .makeDummy(country: "ES", name: "Madrid", id: 1, coordinates: .init(latitude: 0, longitude: 0)),
            .makeDummy(country: "ES", name: "Barcelona", id: 2, coordinates: .init(latitude: 0, longitude: 0)),
            .makeDummy(country: "ES", name: "Sevilla", id: 3, coordinates: .init(latitude: 0, longitude: 0))
        ]
        cityDataSourceMock.result = .success(cities)
        favoritesDataSourceMock.allFavoriteIDsResult = .success([1, 2])
        
        // When
        let result = try await sut.getCities()
        
        // Then
        XCTAssertFalse(result.isEmpty)
        XCTAssertEqual(result.count, cities.count)
        XCTAssertFalse(result.filter{ $0.isFavorite }.isEmpty)
    }
    
    func testFilterSortOrderCityThenCountry() async throws {
        // Given
        let cities: [City] = [
            .makeDummy(country: "AU", name: "Sydney", id: 3, coordinates: .init(latitude: 0, longitude: 0)),
            .makeDummy(country: "US", name: "Denver", id: 1, coordinates: .init(latitude: 0, longitude: 0)),
            .makeDummy(country: "US", name: "Albuquerque", id: 2, coordinates: .init(latitude: 0, longitude: 0))
        ]
        cityDataSourceMock.result = .success(cities)
        favoritesDataSourceMock.allFavoriteIDsResult = .success([1])

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
