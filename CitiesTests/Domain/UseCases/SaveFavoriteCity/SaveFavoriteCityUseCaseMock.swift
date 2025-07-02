//
//  SaveFavoriteCityUseCaseMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

final class SaveFavoriteCityUseCaseMock: SaveFavoriteCityUseCaseContract, @unchecked Sendable {
    var result: Result<Void, Error>?
    
    func addFavorite(_ id: Int) async throws {
        guard let result else {
            fatalError("No result provided")
        }
        
        switch result {
        case .success: ()
        case .failure(let error): throw error
        }
    }
}
