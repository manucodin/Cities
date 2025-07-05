//
//  CityServiceTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import XCTest

final class CityServiceTests: XCTestCase {
    private var sut: CityService!
    private var clientMock: HTTPClientMock!
    
    override func setUp() {
        super.setUp()
        clientMock = HTTPClientMock()
        sut = CityService(httpClient: clientMock)
    }
    
    override func tearDown() {
        super.tearDown()
        clientMock = nil
        sut = nil
    }
    
    
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
        clientMock.result = .success(json)
        
        // When
        let cities = try await sut.fetchCities()

        // Then
        XCTAssertEqual(cities.count, 1)
        XCTAssertEqual(cities.first?.name, "Testville")
        XCTAssertEqual(cities.first?.coordinates?.latitude, 56.78)
    }

    func testFetchCitiesErrorNetworkError() async {
        // Given
        clientMock.result = .failure(NetworkError.networkError)

        do {
            // When
            _ = try await sut.fetchCities()
            
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
        clientMock.result = .success(Data("not valid json".utf8))

        do {
            // When
            _ = try await sut.fetchCities()
            
            // Then
            XCTFail("Expected decoding error")
        } catch { }
    }
}
