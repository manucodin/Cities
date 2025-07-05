//
//  WeatherElementDTO+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

extension WeatherElementDTO {
    static func makeDummy(id: Int? = nil, main: String? = nil, description: String? = nil, icon: String? = nil) -> WeatherElementDTO {
        return .init(id: id, main: main, description: description, icon: icon)
    }
}
