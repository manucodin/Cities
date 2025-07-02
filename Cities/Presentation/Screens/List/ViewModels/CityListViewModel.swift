//
//  CityListViewModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation
import Combine

final class CityListViewModel: ObservableObject {
    @Published var cities: [City] = []
    @Published var filteredCities: [City] = []
    @Published var isLoading = true
    @Published var errorMessage: String?
    
    private let getCitiesUseCase: GetCitiesUseCaseContract

    init(getCitiesUseCase: GetCitiesUseCaseContract = GetCitiesUseCase()) {
        self.getCitiesUseCase = getCitiesUseCase
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
    
    private func handleError(_ error: Error) {
        if let error = error as? NetworkError {
            errorMessage = error.localizedError
        } else {
            errorMessage = "unexpected_error"
        }
    }
}
