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
    private var saveFavoriteCityUseCaseMock: SaveFavoriteCityUseCaseMock!
    private var deleteFavoriteCityUseCaseMock: DeleteFavoriteCityUseCaseMock!
    
    override func setUp() {
        super.setUp()
        getCitiesUseCaseMock = GetCitiesUseCaseMock()
        saveFavoriteCityUseCaseMock = SaveFavoriteCityUseCaseMock()
        deleteFavoriteCityUseCaseMock = DeleteFavoriteCityUseCaseMock()
        sut = CityListViewModel(
            getCitiesUseCase: getCitiesUseCaseMock,
            saveFavoriteCityUseCase: saveFavoriteCityUseCaseMock,
            deleteFavoriteCityUseCase: deleteFavoriteCityUseCaseMock
        )
    }
    
    override func tearDown() {
        super.tearDown()
        getCitiesUseCaseMock = nil
        sut = nil
    }
    
    @MainActor
    func testFetchCities() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "AU", name: "Sydney", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Denver", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Albuquerque", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        
        // When
        await sut.fetchCities()
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.count, cities.count)
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
    
    @MainActor
    func testFilterWithPrefixExpectedCities() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "US", name: "Alabama", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Albuquerque", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "AU", name: "Sydney", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Arizona", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        
        // When
        await sut.fetchCities()
        await sut.searchCities("Al")
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.map{ $0.name }, ["Alabama", "Albuquerque"])
    }
    
    @MainActor
    func testFilterIsCaseInsensitive() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "AU", name: "Sydney", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "ES", name: "santander", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)

        
        // When
        await sut.fetchCities()
        await sut.searchCities("S")
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.map{ $0.name }, ["Sydney", "santander"])
    }
    
    @MainActor
    func testFilterWithNoMatchesReturnsEmptyArray() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "ES", name: "Madrid", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        
        // When
        await sut.fetchCities()
        await sut.searchCities("X")

        // Then
        XCTAssertTrue(sut.filteredCities.isEmpty)
    }
    
    @MainActor
    func testFilterSortOrderCityThenCountry() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "NL", name: "Amsterdam", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "FR", name: "Paris", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Paris", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)

        
        // When
        await sut.fetchCities()
        await sut.searchCities("")
        
        // Then
        XCTAssertFalse(sut.filteredCities.isEmpty)
        XCTAssertEqual(sut.filteredCities.map { "\($0.name),\($0.country)" }, ["Amsterdam,NL", "Paris,FR", "Paris,US"])
    }
    
    @MainActor
    func testAddFavorite() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "NL", name: "Amsterdam", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "FR", name: "Paris", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Paris", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        saveFavoriteCityUseCaseMock.result = .success(())
        
        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])
        
        // Then
        XCTAssertTrue(sut.filteredCities[0].isFavorite)
    }
    
    @MainActor
    func testAddFavoriteError() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "NL", name: "Amsterdam", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "FR", name: "Paris", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Paris", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        saveFavoriteCityUseCaseMock.result = .failure(NSError(domain: "", code: 0))
        
        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])
    
        // Then
        XCTAssertNotNil(sut.errorMessage)
    }
    
    @MainActor
    func testDeleteFavorite() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "NL", name: "Amsterdam", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: true),
            .makeDummy(country: "FR", name: "Paris", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Paris", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        deleteFavoriteCityUseCaseMock.result = .success(())
        
        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])

        // Then
        XCTAssertFalse(sut.filteredCities[0].isFavorite)
    }
    
    @MainActor
    func testDeleteFavoriteError() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(country: "NL", name: "Amsterdam", id: 1, coordinates: .init(latitude: 0, longitude: 0), isFavorite: true),
            .makeDummy(country: "FR", name: "Paris", id: 2, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(country: "US", name: "Paris", id: 3, coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        deleteFavoriteCityUseCaseMock.result = .failure(NSError(domain: "", code: 0))

        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])

        // Then
        XCTAssertNotNil(sut.errorMessage)
    }
}
