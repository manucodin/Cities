//
//  WeatherServiceTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import XCTest

final class WeatherServiceTests: XCTestCase {
    
    func testFetchWeatherData() async throws {
        // Given
        let json = """
        {
            "coord": {
                "lon": 34.2833,
                "lat": 44.55
            },
            "weather": [
                {
                    "id": 800,
                    "main": "Clear",
                    "description": "clear sky",
                    "icon": "01d"
                }
            ],
            "base": "stations",
            "main": {
                "temp": 25.12,
                "feels_like": 25.1,
                "temp_min": 25.12,
                "temp_max": 25.12,
                "pressure": 1017,
                "humidity": 54,
                "sea_level": 1017,
                "grnd_level": 989
            },
            "visibility": 10000,
            "wind": {
                "speed": 2.23,
                "deg": 141,
                "gust": 2.85
            },
            "clouds": {
                "all": 0
            },
            "dt": 1751704018,
            "sys": {
                "country": "UA",
                "sunrise": 1751681041,
                "sunset": 1751736631
            },
            "timezone": 10800,
            "id": 707860,
            "name": "Gurzuf",
            "cod": 200
        }
        """.data(using: .utf8)!

        let mockClient = HTTPClientMock(result: .success(json))
        let service = WeatherService(httpClient: mockClient)
        
        // When
        let weather = try await service.fetchWeather(params: [:])
        
        // Then
        XCTAssertNotNil(weather.main)
        XCTAssertNotNil(weather.weather)
        XCTAssertFalse(weather.weather?.isEmpty ?? true)
    }
    
    func testFetchWeatherDataErrorNetworkError() async throws {
        // Given
        let mockClient = HTTPClientMock(result: .failure(NetworkError.networkError))
        let service = WeatherService(httpClient: mockClient)

        do {
            // When
            _ = try await service.fetchWeather(params: [:])
            
            // Then
            XCTFail("Expected error to be thrown")
        } catch (let error){
            if let error = error as? NetworkError {
                XCTAssertEqual(error, NetworkError.networkError)
            } else {
                XCTFail("Expected error type")
            }
        }
    }
    
    func testFetchWeatherDataErrorInvalidJSON() async throws {
        // Given
        let invalidJSON = Data("not valid json".utf8)
        let mockClient = HTTPClientMock(result: .success(invalidJSON))
        let service = WeatherService(httpClient: mockClient)

        do {
            // When
            _ = try await service.fetchWeather(params: [:])
            
            // Then
            XCTFail("Expected decoding error")
        } catch { }
    }
}
