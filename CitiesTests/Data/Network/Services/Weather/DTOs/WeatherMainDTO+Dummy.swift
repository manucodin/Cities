//
//  WeatherMainDTO+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

extension WeatherMainDTO {
    static func makeDummy(
        temp: Double? = nil,
        feelsLike: Double? = nil,
        tempMin: Double? = nil,
        tempMax: Double? = nil,
        pressure: Int? = nil,
        humidity: Int? = nil
    ) -> WeatherMainDTO {
        return .init(temp: temp, feelsLike: feelsLike, tempMin: tempMin, tempMax: tempMax, pressure: pressure, humidity: humidity)
    }
}
