//
//  CityDetailViewModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 4/7/25.
//

import Foundation
import Combine

final class CityDetailViewModel: ObservableObject {
    @Published var cityDetail: CityDetailRenderModel?
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    
    private let selectedCity: CityRenderModel
    private let getCityDetailUseCase: GetCityDetailUseCaseContract
    
    init(selectedCity: CityRenderModel, getCityDetailUseCase: GetCityDetailUseCaseContract = GetCityDetailUseCase()) {
        self.selectedCity = selectedCity
        self.getCityDetailUseCase = getCityDetailUseCase
    }
    
    @MainActor
    func fetchWeather() async {
        defer {
            isLoading = false
        }
        
        isLoading = true
        do {
            let result = try await getCityDetailUseCase.getWeather(city: selectedCity)
            cityDetail = result
        } catch let error {
            handleError(error)
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
