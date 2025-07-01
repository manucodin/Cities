//
//  GetCitiesUseCase.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

protocol GetCitiesUseCaseContract: Sendable {
    func getCities() async throws -> [City]
}

final class GetCitiesUseCase: GetCitiesUseCaseContract, @unchecked Sendable {
    private let dataSource: CityDataSourceProtocol
    
    init(dataSource: CityDataSourceProtocol = CityDataSource()) {
        self.dataSource = dataSource
    }
    
    func getCities() async throws -> [City] {
        let result = try await dataSource.fetchCities()
        return result
    }
}
