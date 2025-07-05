//
//  WeatherElementDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

struct WeatherElementDTO: Codable, Sendable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
