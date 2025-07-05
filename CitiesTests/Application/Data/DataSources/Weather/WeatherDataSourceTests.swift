//
//  WeatherDataSourceTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import XCTest

final class WeatherDataSourceTests: XCTestCase {
    private var sut: WeatherDataSource!
    private var serviceMock: WeatherServiceMock!
    
    override func setUp() {
        super.setUp()
        serviceMock = WeatherServiceMock()
        sut = WeatherDataSource(weatherService: serviceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        serviceMock = nil
        sut = nil
    }
    
    func testFetchWeather() async throws {
        // Given
        let weather: [WeatherElementDTO] = [.makeDummy(id: 1, main: "Test", description: "Test", icon: "Test")]
        let mainWeather: WeatherMainDTO = .makeDummy(temp: 20.0, feelsLike: 18.0, tempMin: 19.0, tempMax: 20.0, pressure: 100, humidity: 100)
        let weatherDTO: WeatherDTO = .makeDummy(weather: weather, main: mainWeather)
        serviceMock.result = .success(weatherDTO)
        
        // When
        let result = try await sut.fetchWeather(latitude: 0, longitude: 0)
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.temp)
        XCTAssertNotNil(result?.feelsLike)
        XCTAssertNotNil(result?.tempMin)
        XCTAssertNotNil(result?.tempMax)
        XCTAssertNotNil(result?.pressure)
        XCTAssertNotNil(result?.humidity)
        XCTAssertNotNil(result?.icon)
    }
    
    func testFetchInvalidWeather() async throws {
        // Given
        let weather: [WeatherElementDTO] = [.makeDummy(id: 1, main: "Test", description: "Test", icon: nil)]
        let mainWeather: WeatherMainDTO = .makeDummy(temp: 20.0, feelsLike: 18.0, tempMin: nil, tempMax: nil, pressure: 100, humidity: 100)
        let weatherDTO: WeatherDTO = .makeDummy(weather: weather, main: mainWeather)
        serviceMock.result = .success(weatherDTO)
        
        // When
        let result = try await sut.fetchWeather(latitude: 0, longitude: 0)
        
        // Then
        XCTAssertNil(result)
    }
}
