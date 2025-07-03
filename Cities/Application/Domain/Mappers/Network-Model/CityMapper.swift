//
//  CityMapper.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import CoreLocation

public class CityMapper {
    public func map(_ dto: CityDTO) -> City? {
        guard let id = dto.id else { return nil }
        guard let name = dto.name else { return nil }
        guard let country = dto.country else { return nil }
        guard let longitude = dto.coordinates?.longitude, let latitude = dto.coordinates?.latitude else { return nil }
        
        return City(
            id: id,
            name: name,
            country: country,
            coordinates: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        )
    }
}
