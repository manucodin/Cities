//
//  GetCitiesUseCase.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

final class GetCitiesUseCase: GetCitiesUseCaseContract, @unchecked Sendable {
    private let cityDataSource: CityDataSourceContract
    private let favoritesDataSource: FavoritesDataSourceContract
    private let mapper = CityRenderModelMapper()
    
    init(cityDataSource: CityDataSourceContract = CityDataSource(), favoritesDataSource: FavoritesDataSourceContract = FavoritesDataSource()) {
        self.cityDataSource = cityDataSource
        self.favoritesDataSource = favoritesDataSource
    }
    
    func getCities() async throws -> [CityRenderModel] {
        async let cities = cityDataSource.fetchCities()
        async let favorites = favoritesDataSource.allFavoriteIDs()
        
        let (citiesList, favoriteIDs) = try await (cities, favorites)
            
        let sortedResults = sortCities(citiesList)
        let renderModels = sortedResults.map{ mapper.map($0, isFavorite: favoriteIDs.contains($0.id)) }
        
        return renderModels
    }
    
    private func sortCities(_ cities: [City]) -> [City] {
        return cities.sorted {
            if $0.name == $1.name {
                return $0.country < $1.country
            } else {
                return $0.name < $1.name
            }
        }
    }
}
