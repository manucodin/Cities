//
//  City+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

@testable import Cities

import CoreLocation
import Foundation

extension City {
    static func makeDummy(
        country: String = "",
        name: String = "",
        id: Int = 0,
        coordinates: CLLocationCoordinate2D = .init(latitude: 0, longitude: 0)
    ) -> City {
        return .init(id: id, name: name, country: country, coordinates: coordinates)
    }
}
