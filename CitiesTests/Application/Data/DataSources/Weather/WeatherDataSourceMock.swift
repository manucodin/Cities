//
//  WeatherDataSourceMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import Foundation

final class WeatherDataSourceMock: WeatherDataSourceContract {
    var result: Result<Weather?, Error>?

    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather? {
        guard let result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let weather): return weather
        case .failure(let error): throw error
        }
    }
}
