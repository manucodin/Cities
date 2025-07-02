//
//  CityDataSourceContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

public protocol CityDataSourceContract {
    func fetchCities() async throws -> [City]
}
