//
//  GetCityDetailUseCaseContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

protocol GetCityDetailUseCaseContract: Sendable {
    func getWeather(city: CityRenderModel) async throws -> CityDetailRenderModel
}
