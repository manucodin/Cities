//
//  FavoritesDataSourceMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import Foundation

final class FavoritesDataSourceMock: FavoritesDataSourceContract {
    public var isFavoriteResult: Result<Bool, Error>?
    public var addFavoriteResult: Result<Void, Error>?
    public var deleteFavoriteResult: Result<Void, Error>?
    public var allFavoriteIDsResult: Result<Set<Int>, Error>?
    
    func isFavorite(_ id: Int) async throws -> Bool {
        guard let isFavoriteResult else {
            fatalError("No result provided")
        }
        
        switch isFavoriteResult {
        case .success(let isFavorite): return isFavorite
        case .failure(let error): throw error
        }
    }
    
    func addFavorite(_ id: Int) async throws {
        guard let addFavoriteResult else {
            fatalError("No result provided")
        }
        
        switch addFavoriteResult {
        case .success(()): ()
        case .failure(let error): throw error
        }
    }
    
    func deleteFavorite(_ id: Int) async throws {
        guard let deleteFavoriteResult else {
            fatalError("No result provided")
        }
        
        switch deleteFavoriteResult {
        case .success(()): ()
        case .failure(let error): throw error
        }
    }
    
    func allFavoriteIDs() async throws -> Set<Int> {
        guard let allFavoriteIDsResult else {
            fatalError("No result provided")
        }
        
        switch allFavoriteIDsResult {
        case .success(let favoritiesIds): return favoritiesIds
        case .failure(let error): throw error
        }
    }
}
