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
            NavigationView {
                Group{
                    if orientation.isLandscape {
                        HStack(spacing: 0) {
                            CityListView(viewModel: viewModel)
                                .frame(width: geoReader.size.width*0.6)
                            Divider()
                            CityMapView(city: .dummy, selectedCity: nil)
                        }
                    } else {
                        CityListView(viewModel: viewModel)
                    }
                }
                .navigationTitle("cities_title")
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
