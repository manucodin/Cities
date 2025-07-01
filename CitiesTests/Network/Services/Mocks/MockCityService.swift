//
//  MockCityService.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import Foundation

public final class MockCityService: CityServiceProtocol {
    private var result: Result<[CityDTO], Error>?

    public func fetchCities() async throws -> [CityDTO] {
        guard let result = result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let cities): return cities
        case .failure(let error): throw error
        }
    }
}
