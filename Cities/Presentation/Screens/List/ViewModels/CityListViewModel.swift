//
//  CityListViewModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation
import Combine

final class CityListViewModel: ObservableObject {
    @Published var filteredCities: [CityRenderModel] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    private var cities: [CityRenderModel] = []
    
    private let getCitiesUseCase: GetCitiesUseCaseContract
    private let saveFavoriteCityUseCase: SaveFavoriteCityUseCaseContract
    private let deleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseContract
    
    init(getCitiesUseCase: GetCitiesUseCaseContract = GetCitiesUseCase(),
         saveFavoriteCityUseCase: SaveFavoriteCityUseCaseContract = SaveFavoriteCityUseCase(),
         deleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseContract = DeleteFavoriteCityUseCase()) {
        self.getCitiesUseCase = getCitiesUseCase
        self.saveFavoriteCityUseCase = saveFavoriteCityUseCase
        self.deleteFavoriteCityUseCase = deleteFavoriteCityUseCase
    }
    
    @MainActor
    func fetchCities() async {
        defer {
            isLoading = false
        }
        
        isLoading = true
        do {
            let result = try await getCitiesUseCase.getCities()
            cities = result
            filteredCities = result
        } catch (let error){
            errorMessage = "Error al cargar ciudades: \(error.localizedDescription)"
        }
    }
    
    @MainActor
    func searchCities(_ value: String) async {
        let searchTerm = value.lowercased()
        let source = cities
        let chunkSize = 1000

        let result = await withTaskGroup(of: (index: Int, result: [CityRenderModel]).self) { group in
            for (i, chunk) in source.chunked(into: chunkSize).enumerated() {
                group.addTask {
                    let filtered = value.isEmpty
                        ? chunk
                        : chunk.filter { $0.name.lowercased().hasPrefix(searchTerm) }
                    return (index: i, result: filtered)
                }
            }

            var partials: [(index: Int, result: [CityRenderModel])] = []

            for await item in group {
                partials.append(item)
            }

            return partials
                .sorted(by: { $0.index < $1.index })
                .flatMap { $0.result }
        }

        filteredCities = result
    }
    
    @MainActor
    func applyFilter(_ filter: Filter) async {
        switch filter {
        case .all:
            filteredCities = cities
        case .favorites:
            await searchFavorites()
        }
    }
    
    @MainActor
    func toggleFavorite(for city: CityRenderModel) async  {
        guard let index = cities.firstIndex(where: { $0.id == city.id }) else { return }
        
        do {
            if city.isFavorite {
                try await deleteFavoriteCityUseCase.deleteFavorite(city.id)
            } else {
                try await saveFavoriteCityUseCase.addFavorite(city.id)
            }
            
            cities[index].isFavorite.toggle()
            filteredCities = cities
        } catch (let error) {
            errorMessage = "Error al actualizar la ciudad favorita: \(error.localizedDescription)"
        }
    }
    
    private func handleError(_ error: Error) {
        if let error = error as? NetworkError {
            errorMessage = error.localizedError
        } else {
            errorMessage = "unexpected_error"
        }
    }
    
    @MainActor
    private func searchFavorites() async {
        let source = cities
        let chunkSize = 1000

        let result = await withTaskGroup(of: (index: Int, result: [CityRenderModel]).self) { group in
            for (i, chunk) in source.chunked(into: chunkSize).enumerated() {
                group.addTask {
                    let filtered = chunk.filter { $0.isFavorite }
                    return (index: i, result: filtered)
                }
            }

            var partials: [(index: Int, result: [CityRenderModel])] = []

            for await item in group {
                partials.append(item)
            }

            return partials
                .sorted(by: { $0.index < $1.index })
                .flatMap { $0.result }
        }

        filteredCities = result
    }
}
