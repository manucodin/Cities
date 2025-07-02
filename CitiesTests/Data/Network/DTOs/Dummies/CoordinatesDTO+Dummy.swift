//
//  CoordinatesDTO+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import Foundation

extension CoordinatesDTO {
    static func makeDummy(lat: Double = 0.0, lon: Double = 0.0) -> CoordinatesDTO {
        return CoordinatesDTO.init(longitude: lat, latitude: lon)
    }
}
