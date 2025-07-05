//
//  GetCitiesUseCaseContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

protocol GetCitiesUseCaseContract: Sendable {
    func getCities() async throws -> [CityRenderModel]
}
