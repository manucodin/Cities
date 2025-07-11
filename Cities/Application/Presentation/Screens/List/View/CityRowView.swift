//
//  CityRowView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

import SwiftUI

struct CityRowView: View {
    let city: CityRenderModel
    let toggleFavorite: () -> Void
    
    var body: some View {
        contentView
            .padding(.vertical, 8)
    }
}

private extension CityRowView {
    @ViewBuilder
    var contentView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                title
                subTitle
            }
            Spacer()
            favoriteButton
        }
    }
    
    @ViewBuilder
    var title: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .foregroundColor(.accentColor)
            Text("\(city.name), \(city.countryFlag) \(city.country)")
                .font(.headline)
                .accessibilityIdentifier("city_list_row_title_\(city.name.lowercased())_\(city.country.lowercased())")
        }
    }
    
    @ViewBuilder
    var subTitle: some View {
        HStack {
            Image(systemName: "globe.europe.africa")
                .foregroundColor(.gray)
            Text("Lat: \(city.coordinates.latitude, specifier: "%.2f")")
            Text("Lon: \(city.coordinates.longitude, specifier: "%.2f")")
        }
        .font(.subheadline)
        .foregroundColor(.secondary)
    }
    
    @ViewBuilder
    var favoriteButton: some View {
        Button(action: toggleFavorite) {
            Image(systemName: city.isFavorite ? "star.fill" : "star")
                .foregroundColor(city.isFavorite ? .yellow : .gray)
        }
        .buttonStyle(.plain)
        .padding(.trailing, 8)
        .accessibilityIdentifier("city_list_row_favorite_button")
        .accessibilityValue(city.isFavorite ? "On": "Off")
    }
}

#Preview {
    CityRowView(city: .dummy, toggleFavorite: {})
}
