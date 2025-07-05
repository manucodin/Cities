//
//  CityListViewModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation
import Combine

final class CityListViewModel: ObservableObject {
    @Published var cities: [CityRenderModel] = []
    @Published var selectedCity: CityRenderModel?
    @Published var searchText: String = ""
    @Published var filter: Filter = .all
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    @Published var showEmptyState: Bool = false
    
    private var citiesRepository: [CityRenderModel] = []
    private var filteredCities: [CityRenderModel] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    private let getCitiesUseCase: GetCitiesUseCaseContract
    private let saveFavoriteCityUseCase: SaveFavoriteCityUseCaseContract
    private let deleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseContract
    
    init(getCitiesUseCase: GetCitiesUseCaseContract = GetCitiesUseCase(),
         saveFavoriteCityUseCase: SaveFavoriteCityUseCaseContract = SaveFavoriteCityUseCase(),
         deleteFavoriteCityUseCase: DeleteFavoriteCityUseCaseContract = DeleteFavoriteCityUseCase()) {
        self.getCitiesUseCase = getCitiesUseCase
        self.saveFavoriteCityUseCase = saveFavoriteCityUseCase
        self.deleteFavoriteCityUseCase = deleteFavoriteCityUseCase
        
        setupObservables()
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
            citiesRepository = result
            filteredCities = result
        } catch (let error){
            handleError(error)
        }
    }
    
    @MainActor
    func searchCities() async {
        let searchTerm = searchText.lowercased()
        let source = filter == .all ? citiesRepository : filteredCities
        let chunkSize = 2000

        guard !searchTerm.isEmpty else {
            cities = source
            return
        }
        
        let result = await withTaskGroup(of: (index: Int, result: [CityRenderModel]).self) { group in
            for (i, chunk) in source.chunked(into: chunkSize).enumerated() {
                if let firstCity = chunk.first, firstCity.name.lowercased().prefix(1) <= searchTerm.prefix(1) {
                    group.addTask {
                        let filtered = searchTerm.isEmpty
                            ? chunk
                            : chunk.filter { $0.name.lowercased().hasPrefix(searchTerm) }
                        return (index: i, result: filtered)
                    }
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

        cities = result
    }

    
    @MainActor
    func applyFilter() async {
        switch filter {
        case .all:
            cities = citiesRepository
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
            
            let id = cities[index].id
            cities[index].isFavorite.toggle()

            if let repositoryIndex = citiesRepository.firstIndex(where: { $0.id == id }) {
                citiesRepository[repositoryIndex].isFavorite.toggle()
            }
        } catch (let error) {
            handleError(error)
        }
    }
}

private extension CityListViewModel {
    private func setupObservables() {
        $cities.dropFirst().drop(untilOutputFrom: $isLoading).sink { [weak self] cities in
            self?.showEmptyState = cities.isEmpty
        }.store(in: &cancellables)
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
        let source = citiesRepository
        let chunkSize = 2000

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

        cities = result
        filteredCities = result
    }
}
