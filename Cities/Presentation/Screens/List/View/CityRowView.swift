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
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundColor(.accentColor)
                    Text("\(city.name), \(city.countryFlag) \(city.country)")
                        .font(.headline)
                }
                
                HStack {
                    Image(systemName: "globe.europe.africa")
                        .foregroundColor(.gray)
                    Text("Lat: \(city.coordinates.latitude, specifier: "%.2f")")
                    Text("Lon: \(city.coordinates.longitude, specifier: "%.2f")")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            Spacer()
            
            Button(action: toggleFavorite) {
                Image(systemName: city.isFavorite ? "star.fill" : "star")
                    .foregroundColor(city.isFavorite ? .yellow : .gray)
            }
            .buttonStyle(.plain)
            .padding(.trailing, 8)
        }
        .padding(.vertical, 8)
    }
}


#Preview {
    CityRowView(city: .dummy, toggleFavorite: {})
}
