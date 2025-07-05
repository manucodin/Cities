//
//  CityDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

public struct CityDTO: Codable {
    public let country: String?
    public let name: String?
    public let id: Int?
    public let coordinates: CoordinatesDTO?
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case name = "name"
        case id = "_id"
        case coordinates = "coord"
    }
}
