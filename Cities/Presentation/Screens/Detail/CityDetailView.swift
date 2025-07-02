//
//  CityDetailView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import SwiftUI

struct CityDetailView: View {
    @Environment(\.dismiss) private var dismiss
    
    let city: CityRenderModel

    var body: some View {
        if #available(iOS 16.0, *) {
            contentView
                .presentationDetents([.fraction(0.4), .medium, .large])
                .presentationDragIndicator(.visible)
        } else {
            contentView
        }
    }
}

private extension CityDetailView {
    @ViewBuilder
    var contentView: some View {
        VStack(alignment: .leading, spacing: 16) {
            header
            infoView
            Spacer()
            button
        }
        .padding()
    }
    
    @ViewBuilder
    var header: some View {
        HStack {
            Text(city.name)
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(city.countryFlag)
                .font(.largeTitle)
        }
    }
    
    @ViewBuilder
    var infoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Country: \(city.country)")
            Text("Flag: \(city.countryFlag)")
            Text("Latitude: \(city.coordinates.latitude, specifier: "%.4f")")
            Text("Longitude: \(city.coordinates.longitude, specifier: "%.4f")")
        }
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    
    @ViewBuilder
    var button: some View {
        HStack {
            Spacer()
            Button {
                dismiss()
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
    CityDetailView(city: .dummy)
}
