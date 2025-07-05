//
//  CityDetailRenderModel+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

extension CityDetailRenderModel {
    static let dummy: CityDetailRenderModel = .init(
        id: 1,
        name: "Gijón",
        country: "ES",
        coordinates: .init(latitude: 43.53573, longitude: -5.66152),
        isFavorite: true,
        tempMin: 10.0,
        tempMax: 20.0,
        weatherIcon: "01d"
    )
}
