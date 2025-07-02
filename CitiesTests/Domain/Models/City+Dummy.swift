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
    static func makeDummy(country: String, name: String, id: Int, coordinates: CLLocationCoordinate2D) -> City {
        return .init(id: id, name: name, country: country, coordinates: coordinates)
    }
}
