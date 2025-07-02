//
//  DeleteFavoriteCityUseCaseContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

protocol DeleteFavoriteCityUseCaseContract: Sendable {
    func deleteFavorite(_ id: Int) async throws
}
