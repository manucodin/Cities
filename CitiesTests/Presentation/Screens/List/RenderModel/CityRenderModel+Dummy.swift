//
//  CityRenderModel+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import Foundation
import CoreLocation

extension CityRenderModel {
    static func makeDummy(id: Int, name: String, country: String, coordinates: CLLocationCoordinate2D, isFavorite: Bool) -> CityRenderModel {
        return .init(id: id, name: name, country: country, coordinates: coordinates, isFavorite: isFavorite)
    }
}
