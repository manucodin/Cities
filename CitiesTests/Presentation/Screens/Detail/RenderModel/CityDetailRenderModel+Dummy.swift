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
        id: Int,
        name: String,
        country: String,
        coordinates: CLLocationCoordinate2D,
        isFavorite: Bool,
        tempMin: Double?,
        tempMax: Double?,
        weatherIcon: String?
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
