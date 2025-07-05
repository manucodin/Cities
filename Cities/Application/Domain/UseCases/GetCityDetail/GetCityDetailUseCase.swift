//
//  GetCityDetailUseCase.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

final class GetCityDetailUseCase: GetCityDetailUseCaseContract, @unchecked Sendable {
    private let weatherDataSource: WeatherDataSourceContract
    private let mapper = CityDetailRenderModelMapper()
    
    init(weatherDataSource: WeatherDataSourceContract = WeatherDataSource()) {
        self.weatherDataSource = weatherDataSource
    }
    
    func getWeather(city: CityRenderModel) async throws -> CityDetailRenderModel {
        let weatherInfo = try await weatherDataSource.fetchWeather(latitude: city.coordinates.latitude, longitude: city.coordinates.longitude)
        return mapper.map(city, weatherInfo: weatherInfo)
    }
}
