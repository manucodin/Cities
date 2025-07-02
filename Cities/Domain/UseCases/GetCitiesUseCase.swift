//
//  GetCitiesUseCase.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

final class GetCitiesUseCase: GetCitiesUseCaseContract, @unchecked Sendable {
    private let dataSource: CityDataSourceContract
    
    init(dataSource: CityDataSourceContract = CityDataSource()) {
        self.dataSource = dataSource
    }
    
    func getCities() async throws -> [City] {
        let result = try await dataSource.fetchCities()
        let sortedResults = result.sorted {
            if $0.name == $1.name {
                return $0.country < $1.country
            } else {
                return $0.name < $1.name
            }
        }
        return sortedResults
    }
}
