//
//  WeatherServiceMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import Foundation

public final class WeatherServiceMock: WeatherServiceContract {
    public var result: Result<WeatherDTO, Error>?

    public func fetchWeather(params: [String : String]) async throws -> WeatherDTO {
        guard let result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let weather): return weather
        case .failure(let error): throw error
        }
    }
}
