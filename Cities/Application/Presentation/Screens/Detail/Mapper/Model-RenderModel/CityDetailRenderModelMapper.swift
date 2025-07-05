//
//  CityDetailRenderModelMapper.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

public class CityDetailRenderModelMapper {
    public func map(_ model: CityRenderModel, weatherInfo: Weather?) -> CityDetailRenderModel {
        return CityDetailRenderModel(
            id: model.id,
            name: model.name,
            country: model.country,
            coordinates: model.coordinates,
            isFavorite: model.isFavorite,
            tempMin: weatherInfo?.tempMin,
            tempMax: weatherInfo?.tempMax,
            weatherIcon: weatherInfo?.icon
        )
    }
}
