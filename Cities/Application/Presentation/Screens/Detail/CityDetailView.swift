//
//  CityDetailView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import SwiftUI

struct CityDetailView: View {
    @Binding var isPresented: Bool
    
    let city: CityRenderModel

    var body: some View {
        contentView
    }
}

private extension CityDetailView {
    @ViewBuilder
    var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            infoView
            button
        }
        .padding()
    }
    
    @ViewBuilder
    var header: some View {
        Text(city.name)
            .font(.title2)
            .fontWeight(.semibold)
            .accessibilityIdentifier("city_detail_header")
    }
    
    @ViewBuilder
    var infoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Country: \(city.country) \(city.countryFlag)")
            Text("Latitude: \(city.coordinates.latitude, specifier: "%.4f")")
            Text("Longitude: \(city.coordinates.longitude, specifier: "%.4f")")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("city_detail_info")
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
    CityDetailView(isPresented: .constant(true), city: .dummy)
}
