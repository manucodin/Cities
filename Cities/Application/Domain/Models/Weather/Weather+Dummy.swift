//
//  Weather+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

extension Weather {
    static let dummy: Weather = .init(
        temp: 25.12,
        feelsLike: 25.1,
        tempMin: 20.5,
        tempMax: 26.0,
        pressure: 1017,
        humidity: 54,
        icon: "01d"
    )
}
