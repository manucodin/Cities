//
//  CityRenderModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import CoreLocation

struct CityRenderModel: Identifiable, Equatable, Hashable, Sendable {
    let id: Int
    let name: String
    let country: String
    let coordinates: CLLocationCoordinate2D
    var isFavorite: Bool
    
    var countryFlag: String {
        country
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
    
    static func == (lhs: CityRenderModel, rhs: CityRenderModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
