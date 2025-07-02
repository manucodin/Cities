//
//  FavoritesDataSource.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

final class FavoritesDataSource: FavoritesDataSourceContract {
    private let repository: FavoriteCityRepositoryContract
    
    init(repository: FavoriteCityRepositoryContract = FavoriteCityRepository()) {
        self.repository = repository
    }
    
    func isFavorite(_ id: Int) async throws -> Bool {
        return try await repository.isFavorite(id)
    }
    
    func addFavorite(_ id: Int) async throws {
        try await repository.addFavorite(id)
    }
    
    func deleteFavorite(_ id: Int) async throws {
        try await repository.addFavorite(id)
    }
    
    func allFavoriteIDs() async throws -> Set<Int> {
        return try await repository.allFavoriteIDs()
    }
}
