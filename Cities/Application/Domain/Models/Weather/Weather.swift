//
//  Weather.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

public struct Weather: Sendable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int
    let icon: String
}
