//
//  WeatherMapperTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import XCTest

final class WeatherMapperTests: XCTestCase {
    private var sut: WeatherMapper!
    
    override func setUp() {
        super.setUp()
        sut = WeatherMapper()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testMapDTO() {
        // Given
        let weatherElementsDTO: [WeatherElementDTO] = [.makeDummy(id: 1, main: "Test", description: "Test", icon: "Test")]
        let mainWeatherDTO: WeatherMainDTO = .makeDummy(temp: 20.0, feelsLike: 18.0, tempMin: 19.0, tempMax: 20.0, pressure: 100, humidity: 100)
        let weatherDTO: WeatherDTO = .makeDummy(weather: weatherElementsDTO, main: mainWeatherDTO)
        
        // When
        let weather = sut.map(weatherDTO)
        
        // Then
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.temp, weatherDTO.main?.temp)
        XCTAssertEqual(weather?.feelsLike, weatherDTO.main?.feelsLike)
        XCTAssertEqual(weather?.tempMin, weatherDTO.main?.tempMin)
        XCTAssertEqual(weather?.tempMax, weatherDTO.main?.tempMax)
        XCTAssertEqual(weather?.pressure, weatherDTO.main?.pressure)
        XCTAssertEqual(weather?.humidity, weatherDTO.main?.humidity)
        XCTAssertEqual(weather?.icon, weatherDTO.weather?.first?.icon)
    }
    
    func testMapInvalidDTO() {
        // Given
        let weatherElementsDTO: [WeatherElementDTO] = [.makeDummy(id: 1, main: "Test", description: "Test", icon: nil)]
        let mainWeatherDTO: WeatherMainDTO = .makeDummy(temp: 20.0, feelsLike: 18.0, tempMin: nil, tempMax: nil, pressure: 100, humidity: 100)
        let weatherDTO: WeatherDTO = .makeDummy(weather: weatherElementsDTO, main: mainWeatherDTO)
        
        // When
        let weather = sut.map(weatherDTO)
        
        // Then
        XCTAssertNil(weather)
    }
}
