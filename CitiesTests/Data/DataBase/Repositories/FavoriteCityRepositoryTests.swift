//
//  FavoriteCityRepositoryTests.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import XCTest
import CoreData

final class FavoriteCityRepositoryTests: XCTestCase {
    private var sut: FavoriteCityRepository!
    private var persistenceController: PersistenceController!
    
    override func setUp() {
        super.setUp()
        persistenceController = PersistenceController(inMemory: true)
        sut = FavoriteCityRepository(context: persistenceController.viewContext)
    }
    
    override func tearDown() {
        super.tearDown()
        persistenceController = nil
        sut = nil
    }
    
    func testAddFavorite() async throws {
        try await sut.addFavorite(43)
        let isFav = try await sut.isFavorite(43)
        XCTAssertTrue(isFav)
    }
    
    func testRemoveFavorite() async throws {
        try await sut.addFavorite(43)
        try await sut.deleteFavorite(43)
        let isFav = try await sut.isFavorite(43)
        XCTAssertFalse(isFav)
    }
    
    func testIsFavoriteTrueWhenCityNotInFavorites() async throws {
        try await sut.addFavorite(999)
        let isFav = try await sut.isFavorite(999)
        XCTAssertTrue(isFav)
    }
    
    func testIsFavoriteFalseWhenCityNotInFavorites() async throws {
        let isFav = try await sut.isFavorite(999)
        XCTAssertFalse(isFav)
    }
    
    func testFetAllFavoriteIDs() async throws {
        try await sut.addFavorite(1)
        try await sut.addFavorite(2)
        try await sut.addFavorite(3)
        let ids = try await sut.allFavoriteIDs()
        XCTAssertEqual(ids, [1, 2, 3])
    }
    
    func testAddFavoriteDoesNotDuplicateEntries() async throws {
        try await sut.addFavorite(5)
        try await sut.addFavorite(5)
        let ids = try await sut.allFavoriteIDs()
        XCTAssertEqual(ids.count, 1)
    }
}
