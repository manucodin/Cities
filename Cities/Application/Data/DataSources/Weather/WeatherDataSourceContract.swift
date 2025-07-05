//
//  WeatherDataSourceContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

public protocol WeatherDataSourceContract {
    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather
}
