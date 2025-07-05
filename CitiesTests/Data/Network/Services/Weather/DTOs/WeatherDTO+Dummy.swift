//
//  WeatherDTO+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

extension WeatherDTO {
    static func makeDummy(weather: [WeatherElementDTO], main: WeatherMainDTO) -> WeatherDTO {
        return .init(weather: weather, main: main)
    }
}
