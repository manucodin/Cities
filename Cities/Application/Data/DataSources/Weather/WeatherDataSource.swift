//
//  WeatherDataSource.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

final class WeatherDataSource: WeatherDataSourceContract {
    private let weatherService: WeatherServiceContract
    private let mapper = WeatherMapper()
    
    init(weatherService: WeatherServiceContract = WeatherService()) {
        self.weatherService = weatherService
    }
    
    func fetchWeather(latitude: Double, longitude: Double) async throws -> Weather? {
        let params: [String: String] = [
            "lat": "\(latitude)",
            "lon": "\(longitude)",
            "appid": "f508e1b2bd346dfcc0b50c85dadd4701",
            "units": "metric"
        ]
        let result = try await weatherService.fetchWeather(params: params)
        return mapper.map(result)
    }
}
