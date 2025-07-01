//
//  CityService.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation

public protocol CityServiceProtocol {
    func fetchCities() async throws -> [CityDTO]
}

public final class CityService: CityServiceProtocol {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    public init() {
        self.httpClient = URLSessionHTTPClient()
    }
    
    public func fetchCities() async throws -> [CityDTO] {
        let data = try await httpClient.get(from: .cities)
        do {
            return try JSONDecoder().decode([CityDTO].self, from: data)
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}
