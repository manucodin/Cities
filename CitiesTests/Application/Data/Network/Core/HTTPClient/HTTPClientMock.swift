//
//  HTTPClientMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import Foundation

final class HTTPClientMock: HTTPClientContract {
    var result: Result<Data, Error>?
    
    func get(from endpoint: any Cities.APIRouteContract, parameters: [String : String]?) async throws -> Data {
        guard let result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let data): return data
        case .failure(let error): throw error
        }
    }
}
