//
//  FavoriteCityRepositoryMock.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import Foundation

final class FavoriteCityRepositoryMock: FavoriteCityRepositoryContract {
    private var favorites: Set<Int> = []

    func addFavorite(_ id: Int) async throws {
        favorites.insert(id)
    }
    
    func deleteFavorite(_ id: Int) async throws {
        favorites.remove(id)
    }
    
    func allFavoriteIDs() async throws -> Set<Int> {
        favorites
    }
    
    func isFavorite(_ id: Int) async throws -> Bool {
        favorites.contains(id)
    }
}
