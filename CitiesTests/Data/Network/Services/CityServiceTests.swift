//
//  CityServiceTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import XCTest

final class CityServiceTests: XCTestCase {

    func testFetchCities() async throws {
        // Given
        let json = """
        [
          {
            "_id": 123,
            "name": "Testville",
            "country": "TS",
            "coord": {
              "lon": 12.34,
              "lat": 56.78
            }
          }
        ]
        """.data(using: .utf8)!

        let mockClient = HTTPClientMock(result: .success(json))
        let service = CityService(httpClient: mockClient)

        // When
        let cities = try await service.fetchCities()

        // Then
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(cities.first?.name, "Testville")
        XCTAssertEqual(cities.first?.coordinates?.latitude, 56.78)
    }

    func testFetchCitiesErrorNetworkError() async {
        // Given
        let mockClient = HTTPClientMock(result: .failure(NetworkError.networkError))
        let service = CityService(httpClient: mockClient)

        do {
            // When
            _ = try await service.fetchCities()
            
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

    func testFetchCitiesErrorInvalidJSON() async {
        // Given
        let invalidJSON = Data("not valid json".utf8)
        let mockClient = HTTPClientMock(result: .success(invalidJSON))
        let service = CityService(httpClient: mockClient)

        do {
            // When
            _ = try await service.fetchCities()
            
            // Then
            XCTFail("Expected decoding error")
        } catch { }
    }
}
