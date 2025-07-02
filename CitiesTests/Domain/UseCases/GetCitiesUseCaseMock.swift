//
//  GetCitiesUseCaseMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import Foundation

final class GetCitiesUseCaseMock: GetCitiesUseCaseContract, @unchecked Sendable {
    var result: Result<[City], Error>?
    
    func getCities() async throws -> [City] {
        guard let result = result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let cities): return cities
        case .failure(let error): throw error
        }
    }
}
