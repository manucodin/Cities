//
//  WeatherServiceContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

public protocol WeatherServiceContract {
    func fetchWeather(params: [String: String]) async throws -> WeatherDTO
}
