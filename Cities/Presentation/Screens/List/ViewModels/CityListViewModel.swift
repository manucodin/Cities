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
    @Published var filteredCities: [CityRenderModel] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    
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
    
    func searchCities(_ value: String) {
        guard value.isEmpty == false else {
            filteredCities = cities
            return
        }
        
        let searchTerm = value.lowercased()
        let result = cities.filter { city in
            city.name.lowercased().hasPrefix(searchTerm)
        }
        filteredCities = result
    }
    
    @MainActor
    func toggleFavorite(for city: CityRenderModel) async  {
        guard let index = cities.firstIndex(where: { $0.id == city.id }) else { return }
        
        do {
            try await saveFavoriteCityUseCase.addFavorite(city.id)
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
}
