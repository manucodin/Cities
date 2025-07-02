//
//  FavoritesDataSourceTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest

final class FavoritesDataSourceTests: XCTestCase {
    private var sut: FavoritesDataSource!
    private var repositoryMock: FavoriteCityRepositoryMock!
    
    override func setUp() {
        super.setUp()
        repositoryMock = FavoriteCityRepositoryMock()
        sut = FavoritesDataSource(repository: repositoryMock)
    }
    
    override func tearDown() {
        super.tearDown()
        repositoryMock = nil
        sut = nil
    }
    
    func testIsFavoriteTrue() async throws {
        // Given
        try await repositoryMock.addFavorite(1)
        // When
        let result = try await sut.isFavorite(1)
        
        // Then
        XCTAssertTrue(result)
    }
    
    func testIsFavoriteFalse() async throws {
        // Given
        try await repositoryMock.addFavorite(1)
        
        // When
        let result = try await sut.isFavorite(2)
        
        // Then
        XCTAssertFalse(result)
    }
    
    func testAddFavorite() async throws {
        // When
        try await sut.addFavorite(1)
        
        // Then
        let result = try await repositoryMock.allFavoriteIDs()
        XCTAssertEqual(result, [1])
    }
    
    func testDeleteFavorite() async throws {
        // Given
        try await repositoryMock.addFavorite(1)
        
        // When
        try await sut.deleteFavorite(1)
        
        // Then
        let result = try await repositoryMock.allFavoriteIDs()
        XCTAssertTrue(result.isEmpty)
    }
    
    func testAllFavoriteIDs() async throws {
        // Given
        try await repositoryMock.addFavorite(1)
        try await repositoryMock.addFavorite(2)
        
        // When
        let result = try await sut.allFavoriteIDs()
        
        // Then
        XCTAssertEqual(result, [1, 2])
    }
}
