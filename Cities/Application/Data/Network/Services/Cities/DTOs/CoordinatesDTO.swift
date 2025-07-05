//
//  CoordinatesDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

struct CoordinatesDTO: Codable {
    let longitude: Double?
    let latitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
