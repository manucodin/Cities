//
//  CityRenderModelMapper.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

public class CityRenderModelMapper {
    public func map(_ model: City, isFavorite: Bool) -> CityRenderModel {
        return CityRenderModel(
            id: model.id,
            name: model.name,
            country: model.country,
            coordinates: model.coordinates,
            isFavorite: isFavorite)
    }
}
