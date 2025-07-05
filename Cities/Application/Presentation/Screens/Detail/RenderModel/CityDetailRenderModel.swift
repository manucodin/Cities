//
//  CityDetailRenderModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

import CoreLocation

public struct CityDetailRenderModel: Sendable {
    public let id: Int
    public let name: String
    public let country: String
    public let coordinates: CLLocationCoordinate2D
    public let isFavorite: Bool
    public let tempMin: Double
    public let tempMax: Double
    
    public var countryFlag: String {
        country
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
    
    private let weatherIcon: String
    
    init(id: Int, name: String, country: String, coordinates: CLLocationCoordinate2D, isFavorite: Bool, tempMin: Double, tempMax: Double, weatherIcon: String) {
        self.id = id
        self.name = name
        self.country = country
        self.coordinates = coordinates
        self.isFavorite = isFavorite
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.weatherIcon = weatherIcon
    }
    
    public var weatherIconURL: URL? {
        return URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png")
    }
}
