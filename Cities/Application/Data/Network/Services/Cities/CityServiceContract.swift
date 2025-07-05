//
//  CityServiceContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

protocol CityServiceContract {
    func fetchCities() async throws -> [CityDTO]
}
