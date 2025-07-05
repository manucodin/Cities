//
//  CityService.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation

public final class CityService: CityServiceContract {
    private let httpClient: HTTPClientContract
    
    init(httpClient: HTTPClientContract = URLSessionClient()) {
        self.httpClient = httpClient
    }
    
    public func fetchCities() async throws -> [CityDTO] {
        let data = try await httpClient.get(from: CityAPIRoutes.cities, parameters: nil)
        do {
            return try JSONDecoder().decode([CityDTO].self, from: data)
        } catch {
            throw NetworkError.invalidResponse
        }
    }
}
