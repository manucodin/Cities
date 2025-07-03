//
//  CityListView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

struct CityListView: View {
    @ObservedObject var viewModel: CityListViewModel

    var body: some View {
        Group {
            if viewModel.isLoading {
                loading
            } else if let errorMessage = viewModel.errorMessage {
                error(errorMessage)
            } else {
                list
            }
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
            cityRow(city)
        }
        .listStyle(.plain)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "search_city_prompt"
        )
        .onChange(of: viewModel.searchText) {
            Task { await viewModel.searchCities() }
        }
        .onChange(of: viewModel.filter) {
            Task { await viewModel.applyFilter() }
        }
        .accessibilityIdentifier("city_list")
    }
    
    @ViewBuilder
    func cityRow(_ city: CityRenderModel) -> some View {
        Button {
            viewModel.selectedCity = city
        } label: {
            CityRowView(city: city) {
                Task {
                    await viewModel.toggleFavorite(for: city)
                }
            }
        }
        .accessibilityIdentifier("city_list_row")
    }
}

#Preview {
    CityListView(viewModel: CityListViewModel())
}
