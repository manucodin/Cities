//
//  CityDetailView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import SwiftUI

struct CityDetailView: View {
    @Binding var isPresented: Bool
    
    @StateObject private var viewModel: CityDetailViewModel
    
    init(isPresented: Binding<Bool>, selectedCity: CityRenderModel) {
        self._isPresented = isPresented
        self._viewModel = StateObject(wrappedValue: CityDetailViewModel(selectedCity: selectedCity))
    }
    
    var body: some View {
        contentView
            .task {
                Task { await viewModel.fetchWeather() }
            }
    }
}

private extension CityDetailView {
    @ViewBuilder
    var contentView: some View {
        Group {
            if viewModel.isLoading {
                loading
            } else {
                detailView
            }
        }.padding()
    }
    
    @ViewBuilder
    var detailView: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            infoView
            button
        }
    }
    
    var loading: some View {
        ProgressView("progress_loading")
    }
    
    @ViewBuilder
    var header: some View {
        HStack {
            title
            Spacer()
            weatherInfo
        }
    }
    
    @ViewBuilder
    var title: some View {
        if let selectedCity = viewModel.cityDetail {
            Text(selectedCity.name)
                .font(.title2)
                .fontWeight(.semibold)
                .accessibilityIdentifier("city_detail_header")
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var weatherInfo: some View {
        if let selectedCity = viewModel.cityDetail {
            Text(String(format: "%.2f / %.2f °C", selectedCity.tempMin, selectedCity.tempMax))
                .font(.footnote)
                .foregroundStyle(.secondary)
            AsyncImage(url: selectedCity.weatherIconURL) { imagePhase in
                switch imagePhase {
                case .empty:
                    ProgressView()
                        .frame(width: 30, height: 30)
                case .success(let image):
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var infoView: some View {
        if let selectedCity = viewModel.cityDetail {
            VStack(alignment: .leading, spacing: 8) {
                Text("Country: \(selectedCity.country) \(selectedCity.countryFlag)")
                Text("Latitude: \(selectedCity.coordinates.latitude, specifier: "%.4f")")
                Text("Longitude: \(selectedCity.coordinates.longitude, specifier: "%.4f")")
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .accessibilityElement(children: .combine)
            .accessibilityIdentifier("city_detail_info")
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    var button: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    isPresented.toggle()
                }
            } label: {
                Label("Open map", systemImage: "map")
                    .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }
}

#Preview {
    CityDetailView(isPresented: .constant(true), selectedCity: .dummy)
}
