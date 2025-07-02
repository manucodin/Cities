//
//  City+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

extension City {
    static let dummy: City = .init(
        id: 1,
        name: "Gijón",
        country: "ES",
        coordinates: .init(latitude: 43.53573, longitude: -5.66152),
        isFavorite: false
    )
}
