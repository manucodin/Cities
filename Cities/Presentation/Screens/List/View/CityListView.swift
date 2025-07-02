//
//  CityListView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

struct CityListView: View {
    @State private var searchText: String = ""
    @State private var filter: Filter = .all
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
            NavigationLink(destination: CityMapView(city: city)) {
                CityRowView(city: city) {
                    Task {
                        await viewModel.toggleFavorite(for: city)
                    }
                }
            }
        }
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "search_city_prompt"
        )
        .onChange(of: searchText) { searchText in
            Task { await viewModel.searchCities(searchText) }
        }
        .onChange(of: filter) { filter in
            Task { await viewModel.applyFilter(filter) }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    ForEach(Filter.allCases) { option in
                        Button {
                            filter = option
                        } label: {
                            Label(option.localizedValue, systemImage: filter == option ? "checkmark" : "")
                        }
                    }
                } label: {
                    Label("filter_button", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
        }
    }
}

#Preview {
    CityListView()
}
