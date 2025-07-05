//
//  WeatherService.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

import Foundation

public final class WeatherService: WeatherServiceContract {
    private let httpClient: HTTPClientContract
    
    init(httpClient: HTTPClientContract = URLSessionClient()) {
        self.httpClient = httpClient
    }
    
    public func fetchWeather(params: [String: String]) async throws -> WeatherDTO {
        let data = try await httpClient.get(from: WeatherAPIRoutes.weather, parameters: params)
        do {
            return try JSONDecoder().decode(WeatherDTO.self, from: data)
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}
