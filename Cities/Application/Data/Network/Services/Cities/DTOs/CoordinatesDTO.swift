//
//  CoordinatesDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

public struct CoordinatesDTO: Codable {
    public let longitude: Double?
    public let latitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
