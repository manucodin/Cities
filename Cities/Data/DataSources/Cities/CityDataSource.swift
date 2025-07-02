//
//  CityDataSource.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

final class CityDataSource: CityDataSourceContract {
    private let cityService: CityServiceProtocol
    private let mapper = CityMapper()
    
    init(cityService: CityServiceProtocol = CityService()) {
        self.cityService = cityService
    }
    
    func fetchCities() async throws -> [City] {
        return try await cityService.fetchCities().compactMap{ mapper.map($0) }
    }
}
