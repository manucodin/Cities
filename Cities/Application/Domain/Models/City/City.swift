//
//  City.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import CoreLocation

public struct City: Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let country: String
    public let coordinates: CLLocationCoordinate2D
}
