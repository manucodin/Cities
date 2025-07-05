//
//  GetCityDetailUseCaseTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import XCTest

final class GetCityDetailUseCaseTests: XCTestCase {
    private var sut: GetCityDetailUseCase!
    private var weatherDataSourceMock: WeatherDataSourceMock!
    
    override func setUp() {
        super.setUp()
        
        weatherDataSourceMock = .init()
        sut = .init(weatherDataSource: weatherDataSourceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        weatherDataSourceMock = nil
        sut = nil
    }
    
    func testGetCityDetail() async throws {
        // Given
        let weather: Weather = .dummy
        weatherDataSourceMock.result = .success(weather)
        
        // When
        let result = try await sut.getWeather(city: .dummy)
        
        // Then
        XCTAssertNotNil(result.tempMin)
        XCTAssertNotNil(result.tempMax)
        XCTAssertNotNil(result.weatherIconURL)
    }
    
    func testGetCityDetailFailure() async throws {
        // Given
        weatherDataSourceMock.result = .success(nil)
        
        // When
        let result = try await sut.getWeather(city: .dummy)

        // Then
        XCTAssertNil(result.tempMin)
        XCTAssertNil(result.tempMax)
        XCTAssertNil(result.weatherIconURL)
    }
}
