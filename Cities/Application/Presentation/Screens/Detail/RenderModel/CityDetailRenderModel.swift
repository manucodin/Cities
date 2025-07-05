//
//  CityDetailRenderModel.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

import CoreLocation

struct CityDetailRenderModel: Sendable {
    let id: Int
    let name: String
    let country: String
    let coordinates: CLLocationCoordinate2D
    let isFavorite: Bool
    let tempMin: Double?
    let tempMax: Double?
    
    var countryFlag: String {
        country
            .uppercased()
            .unicodeScalars
            .compactMap { UnicodeScalar(127397 + $0.value) }
            .map { String($0) }
            .joined()
    }
    
    var weatherIconURL: URL? {
        guard let weatherIcon else { return nil }
        
        return URL(string: "https://openweathermap.org/img/wn/\(weatherIcon)@2x.png")
    }
    
    private let weatherIcon: String?
    
    init(id: Int, name: String, country: String, coordinates: CLLocationCoordinate2D, isFavorite: Bool, tempMin: Double?, tempMax: Double?, weatherIcon: String?) {
        self.id = id
        self.name = name
        self.country = country
        self.coordinates = coordinates
        self.isFavorite = isFavorite
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.weatherIcon = weatherIcon
    }
}
