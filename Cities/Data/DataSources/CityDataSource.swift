//
//  CityDataSource.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

final class CityDataSource: CityDataSourceContract {
    private let service: CityServiceProtocol
    private let mapper = CityMapper()
    
    init(service: CityServiceProtocol = CityService()) {
        self.service = service
    }
    
    func fetchCities() async throws -> [City] {
        return try await service.fetchCities().compactMap{ mapper.map($0) }
    }
}
