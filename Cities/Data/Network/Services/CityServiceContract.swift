//
//  CityServiceContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

public protocol CityServiceProtocol {
    func fetchCities() async throws -> [CityDTO]
}
