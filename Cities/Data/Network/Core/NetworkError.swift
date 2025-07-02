//
//  NetworkError.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

enum NetworkError: Error {
    case invalidURL
    case networkError
    case invalidResponse
    
    var localizedError: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .networkError:
            return "Network Error"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
