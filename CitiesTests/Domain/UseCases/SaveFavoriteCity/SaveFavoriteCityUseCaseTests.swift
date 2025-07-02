//
//  SaveFavoriteCityUseCaseTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest

final class SaveFavoriteCityUseCaseTests: XCTestCase {
    private var sut: SaveFavoriteCityUseCase!
    private var dataSourceMock: FavoritesDataSourceMock!
    
    override func setUp() {
        super.setUp()
        dataSourceMock = FavoritesDataSourceMock()
        sut = SaveFavoriteCityUseCase(dataSource: dataSourceMock)
    }
    
    override func tearDown() {
        super.tearDown()
        dataSourceMock = nil
        sut = nil
    }
    
    func testAddFavorite() async throws {
        // Given
        dataSourceMock.addFavoriteResult = .success(())
        
        // When
        try await sut.addFavorite(1)
    }
}
