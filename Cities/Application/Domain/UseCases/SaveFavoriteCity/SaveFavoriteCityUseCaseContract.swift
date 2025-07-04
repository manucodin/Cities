//
//  SaveFavoriteCityUseCaseContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

protocol SaveFavoriteCityUseCaseContract: Sendable {
    func addFavorite(_ id: Int) async throws
}
