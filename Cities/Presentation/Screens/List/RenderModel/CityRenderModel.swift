//
//  CityRenderModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import CoreLocation

public struct CityRenderModel: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let country: String
    public let coordinates: CLLocationCoordinate2D
    public var isFavorite: Bool
    
    public var countryFlag: String {
        country
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
}
