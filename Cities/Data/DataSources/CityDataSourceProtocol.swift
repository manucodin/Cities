//
//  CityDataSourceProtocol.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

public protocol CityDataSourceProtocol {
    func fetchCities() async throws -> [City]
}
