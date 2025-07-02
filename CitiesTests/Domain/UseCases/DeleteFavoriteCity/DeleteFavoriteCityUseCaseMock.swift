//
//  DeleteFavoriteCityUseCaseMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

final class DeleteFavoriteCityUseCaseMock: DeleteFavoriteCityUseCaseContract, @unchecked Sendable {
    var result: Result<Void, Error>?
    
    func deleteFavorite(_ id: Int) async throws {
        guard let result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success(let cities): ()
        case .failure(let error): throw error
        }
    }
}
