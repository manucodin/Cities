//
//  CityListView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

struct CityListView: View {
    @StateObject private var viewModel = CityListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    loading
                } else if let errorMessage = viewModel.errorMessage {
                    error(errorMessage)
                } else {
                    List(viewModel.cities, id: \.id) { city in
                        CityRowView(city: city)
                    }
                }
            }
            .navigationTitle("cities_title")
        }
        .task {
            await viewModel.fetchCities()
        }
    }
}

private extension CityListView {
    @ViewBuilder
    var loading: some View {
        ProgressView("progress_loading")
    }
    
    @ViewBuilder
    func error(_ errorMessage: String) -> some View {
        Text(errorMessage)
            .foregroundColor(.red)
    }
}

#Preview {
    CityListView()
}
