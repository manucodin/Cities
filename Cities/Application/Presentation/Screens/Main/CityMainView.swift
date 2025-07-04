//
//  CityMainView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 3/7/25.
//

import SwiftUI

struct CitiesMainView: View {
    @State private var orientation = UIDevice.current.orientation
    @StateObject private var viewModel = CityListViewModel()
    
    var body: some View {
        GeometryReader { geoReader in
            NavigationStack {
                Group {
                    if orientation.isLandscape {
                        HStack(spacing: 0) {
                            CityListView(viewModel: viewModel)
                                .frame(width: geoReader.size.width*0.6)
                            Divider()
                            CityMapView(selectedCity: $viewModel.selectedCity)
                        }
                    } else {
                        CityListView(viewModel: viewModel)
                            .navigationDestination(item: $viewModel.selectedCity) { city in
                                CityMapView(selectedCity: .constant(city))
                            }
                    }
                }
                .navigationTitle("cities_title")
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "search_city_prompt"
                )
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            ForEach(Filter.allCases) { option in
                                Button {
                                    viewModel.filter = option
                                } label: {
                                    if viewModel.filter == option {
                                        Label(option.localizedValue, systemImage: "checkmark")
                                    } else {
                                        Text(option.localizedValue)
                                    }
                                }
                            }
                        } label: {
                            Label("filter_button", systemImage: "line.3.horizontal.decrease.circle")
                        }
                    }
                }
            }
        }
        .detectOrientation($orientation)
        .task {
            await viewModel.fetchCities()
        }
    }
}

#Preview {
    CitiesMainView()
}
