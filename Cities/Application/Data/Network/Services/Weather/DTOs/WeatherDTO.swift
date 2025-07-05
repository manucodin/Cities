//
//  WeatherDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

struct WeatherDTO: Codable, Sendable {
    let weather: [WeatherElementDTO]?
    let main: WeatherMainDTO?
}
