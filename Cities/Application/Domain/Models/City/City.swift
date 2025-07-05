//
//  City.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import CoreLocation

struct City: Identifiable, Sendable {
    let id: Int
    let name: String
    let country: String
    let coordinates: CLLocationCoordinate2D
}
