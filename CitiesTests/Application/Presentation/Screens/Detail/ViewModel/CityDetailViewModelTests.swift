//
//  CityDetailViewModelTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//


@testable import Cities

import XCTest

final class CityDetailViewModelTests: XCTestCase {
    private var sut: CityDetailViewModel!
    private var getCityDetailUseCaseMock: GetCityDetailUseCaseMock!
    
    override func setUp() {
        super.setUp()
        getCityDetailUseCaseMock = GetCityDetailUseCaseMock()
        sut = CityDetailViewModel(selectedCity: .dummy, getCityDetailUseCase: getCityDetailUseCaseMock)
    }
    
    override func tearDown() {
        super.tearDown()
        getCityDetailUseCaseMock = nil
        sut = nil
    }
    
    @MainActor
    func testFetchCities() async throws {
        // Given
        getCityDetailUseCaseMock.result = .success(.dummy)
        
        // When
        await sut.fetchWeather()
        
        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
        XCTAssertNotNil(sut.cityDetail)
    }
    
    @MainActor
    func testFetchCitiesFailure() async throws {
        //Given
        getCityDetailUseCaseMock.result = .failure(NetworkError.invalidResponse)
        
        // When
        await sut.fetchWeather()
        
        // Then
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertNil(sut.cityDetail)
    }
}
