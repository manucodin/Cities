//
//  CityDTO+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

@testable import Cities

import Foundation

extension CityDTO {
    static func makeDummy(country: String? = nil, name: String? = nil, id: Int? = nil, coordinates: CoordinatesDTO? = nil) -> CityDTO {
        return .init(country: country, name: name, id: id, coordinates: coordinates)
    }
}
