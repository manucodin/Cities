//
//  WeatherMainDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

struct WeatherMainDTO: Codable, Sendable {
    let temp: Double?
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
}
