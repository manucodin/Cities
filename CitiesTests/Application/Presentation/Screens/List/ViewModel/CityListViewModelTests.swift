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
            .makeDummy(id: 3, name: "Sydney", country: "AU", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 1, name: "Denver", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 1, name: "Albuquerque", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
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
    
    @MainActor
    func testFilterWithPrefixExpectedCities() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Alabama", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 2, name: "Albuquerque", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 3, name: "Sydney", country: "AU", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 4, name: "Arizona", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        sut.searchText = "Al"
        
        // When
        await sut.fetchCities()
        await sut.searchCities()
        
        // Then
        XCTAssertFalse(sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.map{ $0.name }, ["Alabama", "Albuquerque"])
    }
    
    @MainActor
    func testFilterIsCaseInsensitive() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Sydney", country: "AU", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 2, name: "santander", country: "ES", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        sut.searchText = "S"
        
        // When
        await sut.fetchCities()
        await sut.searchCities()
        
        // Then
        XCTAssertFalse(sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.map{ $0.name }, ["Sydney", "santander"])
    }
    
    @MainActor
    func testFilterWithNoMatchesReturnsEmptyArray() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Madrid", country: "ES", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        sut.searchText = "X"
        
        // When
        await sut.fetchCities()
        await sut.searchCities()

        // Then
        XCTAssertTrue(sut.cities.isEmpty)
    }
    
    @MainActor
    func testFilterSortOrderCityThenCountry() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Amsterdam", country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy( id: 3, name: "Paris", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        sut.searchText = ""
        
        // When
        await sut.fetchCities()
        await sut.searchCities()
        
        // Then
        XCTAssertFalse(sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.map { "\($0.name),\($0.country)" }, ["Amsterdam,NL", "Paris,FR", "Paris,US"])
    }
    
    @MainActor
    func testAddFavorite() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Amsterdam",country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 3, name: "Paris", country: "US" , coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        saveFavoriteCityUseCaseMock.result = .success(())
        
        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])
        
        // Then
        XCTAssertTrue(sut.cities[0].isFavorite)
    }
    
    @MainActor
    func testAddFavoriteError() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Amsterdam", country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy( id: 3, name: "Paris", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
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
            .makeDummy(id: 1, name: "Amsterdam", country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: true),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 3, name: "Paris", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        deleteFavoriteCityUseCaseMock.result = .success(())
        
        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])

        // Then
        XCTAssertFalse(sut.cities[0].isFavorite)
    }
    
    @MainActor
    func testDeleteFavoriteError() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Amsterdam", country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: true),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 3, name: "Paris", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        deleteFavoriteCityUseCaseMock.result = .failure(NSError(domain: "", code: 0))

        // When
        await sut.fetchCities()
        await sut.toggleFavorite(for: cities[0])

        // Then
        XCTAssertNotNil(sut.errorMessage)
    }
    
    @MainActor
    func testApplyFilterAll() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Amsterdam", country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: true),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 3 , name: "Paris", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        sut.filter = .all
        
        // When
        await sut.fetchCities()
        await sut.applyFilter()
        
        XCTAssertFalse(sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.count, cities.count)
    }
    
    @MainActor
    func testApplyFilterFavorites() async throws {
        // Given
        let cities: [CityRenderModel] = [
            .makeDummy(id: 1, name: "Amsterdam", country: "NL", coordinates: .init(latitude: 0, longitude: 0), isFavorite: true),
            .makeDummy(id: 2, name: "Paris", country: "FR", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false),
            .makeDummy(id: 3, name: "Paris", country: "US", coordinates: .init(latitude: 0, longitude: 0), isFavorite: false)
        ]
        getCitiesUseCaseMock.result = .success(cities)
        sut.filter = .favorites
        
        // When
        await sut.fetchCities()
        await sut.applyFilter()
        
        XCTAssertFalse(sut.cities.isEmpty)
        XCTAssertEqual(sut.cities.count, 1)
    }
}
