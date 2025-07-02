//
//  CityListViewModelTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest

final class CityListViewModelTests: XCTestCase {
    private var sut: CityListViewModel!
    private var getCitiesUseCaseMock: GetCitiesUseCaseMock!
    
    override func setUp() {
        super.setUp()
        getCitiesUseCaseMock = GetCitiesUseCaseMock()
        sut = CityListViewModel(getCitiesUseCase: getCitiesUseCaseMock)
    }
    
    override func tearDown() {
        super.tearDown()
        getCitiesUseCaseMock = nil
        sut = nil
    }
    
    @MainActor
    func testFetchCities() async throws {
        // Given
        let cities: [City] = [
            .makeDummy(country: "AU", name: "Sydney", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Denver", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Albuquerque", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        
        // When
        await sut.fetchCities()
        
        // Then
        XCTAssertFalse(sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.count, cities.count)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }
    
    @MainActor
    func testFetchCitiesError() async throws {
        // Given
        getCitiesUseCaseMock.result = .failure(NetworkError.networkError)
        
        // When
        await sut.fetchCities()
        
        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.errorMessage)
    }
    
    func testFilterWithPrefixExpectedCities() {
        // Given
        let cities: [City] = [
            .makeDummy(country: "US", name: "Alabama", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Albuquerque", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "AU", name: "Sydney", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Arizona", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        sut.cities = cities
        sut.filteredCities = cities
        
        // When
        sut.searchCities("Al")
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.map{ $0.name }, ["Alabama", "Albuquerque"])
    }
    
    func testFilterIsCaseInsensitive() {
        // Given
        let cities: [City] = [
            .makeDummy(country: "AU", name: "Sydney", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "ES", name: "santander", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        sut.cities = cities
        sut.filteredCities = cities
        
        // When
        sut.searchCities("S")
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.map{ $0.name }, ["Sydney", "santander"])
    }
    
    func testFilterWithNoMatchesReturnsEmptyArray() {
        // Given
        let cities: [City] = [
            .makeDummy(country: "ES", name: "Madrid", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        sut.cities = cities
        sut.filteredCities = cities
        
        // When
        sut.searchCities("X")

        // Then
        XCTAssertTrue(sut.filteredCities.isEmpty)
    }
    
    func testFilterSortOrderCityThenCountry() {
        // Given
        let cities: [City] = [
            .makeDummy(country: "NL", name: "Amsterdam", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "FR", name: "Paris", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Paris", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        sut.cities = cities
        sut.filteredCities = cities
        
        // When
        sut.searchCities("")
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.map { "\($0.name),\($0.country)" }, ["Amsterdam,NL", "Paris,FR", "Paris,US"])
    }
}
