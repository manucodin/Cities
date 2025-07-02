//
//  SaveFavoriteCityUseCase.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

final class SaveFavoriteCityUseCase: SaveFavoriteCityUseCaseContract, @unchecked Sendable {
    private let dataSource: FavoritesDataSourceContract
    
    init(dataSource: FavoritesDataSourceContract = FavoritesDataSource()) {
        self.dataSource = dataSource
    }
    
    func addFavorite(_ id: Int) async throws {
        try await dataSource.addFavorite(id)
    }
}
