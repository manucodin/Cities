//
//  CityDTO.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

struct CityDTO: Codable {
    let country: String?
    let name: String?
    let id: Int?
    let coordinates: CoordinatesDTO?
    
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case name = "name"
        case id = "_id"
        case coordinates = "coord"
    }
}
