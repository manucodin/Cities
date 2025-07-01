//
//  CityRowView.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import SwiftUI

import SwiftUI

struct CityRowView: View {
    let city: City

    var body: some View {
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
        .padding(.vertical, 8)
    }
}


#Preview {
    CityRowView(city: .dummy)
}
