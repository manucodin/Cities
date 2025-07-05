//
//  WeatherMapper.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

final class WeatherMapper {
    func map(_ dto: WeatherDTO) -> Weather? {
        guard let tempMin = dto.main?.tempMin else { return nil }
        guard let tempMax = dto.main?.tempMax else { return nil }
        guard let icon = dto.weather?.first?.icon else { return nil }
        
        return Weather(
            temp: dto.main?.temp ?? .zero,
            feelsLike: dto.main?.feelsLike ?? .zero,
            tempMin: tempMin,
            tempMax: tempMax,
            pressure: dto.main?.pressure ?? .zero,
            humidity: dto.main?.humidity ?? .zero,
            icon: icon
        )
    }
}
