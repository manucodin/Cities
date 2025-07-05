//
//  WeatherAPIRoutes.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

import Foundation

enum WeatherAPIRoutes: String, APIRouteContract {
    case weather

    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5"
    }
    
    var path: String {
        switch self {
        case .weather: return "\(baseURL)/weather"
        }
    }
}
