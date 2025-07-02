//
//  CityListView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

struct CityListView: View {
    @State private var searchText: String = ""
    @StateObject private var viewModel = CityListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    loading
                } else if let errorMessage = viewModel.errorMessage {
                    error(errorMessage)
                } else {
                    list
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
    
    @ViewBuilder
    var list: some View {
        List(viewModel.filteredCities, id: \.id) { city in
            CityRowView(city: city)
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "search_city_prompt"
        )
        .onChange(of: searchText) { searchText in
            viewModel.searchCities(searchText)
        }
    }
}

#Preview {
    CityListView()
}
