//
//  FavoriteCityRepository.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import Foundation
@preconcurrency import CoreData

final class FavoriteCityRepository: FavoriteCityRepositoryContract {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.viewContext) {
        self.context = context
    }
    
    func isFavorite(_ id: Int) async throws -> Bool {
        try await context.perform {
            let request = NSFetchRequest<FavoriteCityEntity>(entityName: "FavoriteCityEntity")
            request.predicate = NSPredicate(format: "id == %d", id)
            request.fetchLimit = 1
            return try self.context.count(for: request) > 0
        }
    }
    
    func addFavorite(_ id: Int) async throws  {
        try await context.perform {
            let entity = FavoriteCityEntity(context: self.context)
            entity.id = Int32(id)
            try self.context.save()
        }
    }
    
    func deleteFavorite(_ id: Int) async throws {
        try await context.perform {
            let request = NSFetchRequest<FavoriteCityEntity>(entityName: "FavoriteCityEntity")
            request.predicate = NSPredicate(format: "id == %d", id)
            
            let results = try self.context.fetch(request)
            results.forEach(self.context.delete)
            try self.context.save()
        }
    }
    
    func allFavoriteIDs() async throws -> Set<Int> {
        try await context.perform {
            let request = NSFetchRequest<FavoriteCityEntity>(entityName: "FavoriteCityEntity")
            let results = try self.context.fetch(request)
            return Set(results.map { Int($0.id) })
        }
    }
}
