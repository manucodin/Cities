//
//  CityAPIRoutes.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation

enum CityAPIRoutes: String, APIRouteContract {
    case cities

    var baseURL: String {
        return "https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1"
    }
    
    var path: String {
        switch self {
        case .cities: return "\(baseURL)/cities.json"
        }
    }
}
