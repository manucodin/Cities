//
//  GetCityDetailUseCaseMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

final class GetCityDetailUseCaseMock: GetCityDetailUseCaseContract, @unchecked Sendable {
    var result: Result<CityDetailRenderModel, Error>?

    func getWeather(city: CityRenderModel) async throws -> CityDetailRenderModel {
        guard let result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let cityDetail): return cityDetail
        case .failure(let error): throw error
        }
    }
}
