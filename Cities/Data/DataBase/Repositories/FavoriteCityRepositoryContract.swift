//
//  FavoriteCityRepositoryContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

protocol FavoriteCityRepositoryContract: Sendable {
    func isFavorite(_ id: Int) async throws -> Bool
    func addFavorite(_ id: Int) async throws
    func deleteFavorite(_ id: Int) async throws
    func allFavoriteIDs() async throws -> Set<Int>
}
