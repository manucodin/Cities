//
//  DeleteFavoriteCityUseCase.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

final class DeleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseContract, @unchecked Sendable {
    private let dataSource: FavoritesDataSourceContract
    
    init(dataSource: FavoritesDataSourceContract = FavoritesDataSource()) {
        self.dataSource = dataSource
    }
    
    func deleteFavorite(_ id: Int) async throws {
        try await dataSource.deleteFavorite(id)
    }
}
