//
//  DeleteFavoriteCityUseCaseTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest

final class DeleteFavoriteCityUseCaseTests: XCTestCase {
    private var sut: DeleteFavoriteCityUseCase!
    private var dataSourceMock: FavoritesDataSourceMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = FavoritesDataSourceMock()
        sut = DeleteFavoriteCityUseCase(dataSource: dataSourceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        dataSourceMock = nil
        sut = nil
    }
    
    func testDeleteFavoriteCity() async throws {
        // Given
        dataSourceMock.deleteFavoriteResult = .success(())
        
        // When
        try await sut.deleteFavorite(1)
    }
}
