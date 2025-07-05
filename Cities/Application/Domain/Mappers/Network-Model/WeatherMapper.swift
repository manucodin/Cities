//
//  WeatherMapper.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

public class WeatherMapper {
    public func map(_ dto: WeatherDTO) -> Weather {
        return Weather(
            temp: dto.main?.temp ?? .zero,
            feelsLike: dto.main?.feelsLike ?? .zero,
            tempMin: dto.main?.tempMin ?? .zero,
            tempMax: dto.main?.tempMax ?? .zero,
            pressure: dto.main?.pressure ?? .zero,
            humidity: dto.main?.humidity ?? .zero,
            icon: dto.weather?.first?.icon ?? ""
        )
    }
}
