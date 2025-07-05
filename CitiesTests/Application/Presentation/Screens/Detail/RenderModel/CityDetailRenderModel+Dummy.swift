//
//  CityDetailRenderModel+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

import Foundation
import CoreLocation

extension CityDetailRenderModel {
    static func makeDummy(
        id: Int = 0,
        name: String = "",
        country: String = "",
        coordinates: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0),
        isFavorite: Bool = false,
        tempMin: Double? = nil,
        tempMax: Double? = nil,
        weatherIcon: String? = nil
    ) -> CityDetailRenderModel {
        return .init(
            id: id,
            name: name,
            country: country,
            coordinates: coordinates,
            isFavorite: isFavorite,
            tempMin: tempMin,
            tempMax: tempMax,
            weatherIcon: weatherIcon
        )
    }
}
