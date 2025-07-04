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
            } else if viewModel.showEmptyState {
                emptyState
            } else if let errorMessage = viewModel.errorMessage {
                error(errorMessage)
            } else {
                list
            }
        }
        .onChange(of: viewModel.searchText) {
            Task { await viewModel.searchCities() }
        }
        .onChange(of: viewModel.filter) {
            Task { await viewModel.applyFilter() }
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
        ErrorStateView(
            imageName: "exclamationmark.bubble.fill",
            title: String(localized: "city_list_error_title"),
            message: errorMessage,
            retryButtonLabel: String(localized: "city_list_error_retry_button"),
            retryAction: {
                Task { await viewModel.fetchCities() }
            }
        )
    }
    
    @ViewBuilder
    var list: some View {
        List(viewModel.cities, id: \.id) { city in
            cityRow(city)
        }
        .listStyle(.plain)
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
    
    @ViewBuilder
    var emptyState: some View {
        EmptyStateView(
            imageName: "tray",
            title: String(localized: "city_list_empty_state_title"),
            message: String(localized: "city_list_empty_state_message")
        )
    }
}

#Preview {
    CityListView(viewModel: CityListViewModel())
}
