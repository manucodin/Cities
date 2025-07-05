//
//  Weather+Dummy.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 5/7/25.
//

@testable import Cities

extension Weather {
    static func makeDummy(
        temp: Double = 0.0,
        feelsLike: Double = 0.0,
        tempMin: Double = 0.0,
        tempMax: Double = 0.0,
        pressure: Int = 0,
        humidity: Int = 0,
        icon: String = ""
    ) -> Weather {
        return .init(
            temp: temp,
            feelsLike: feelsLike,
            tempMin: tempMin,
            tempMax: tempMax,
            pressure: pressure,
            humidity: humidity,
            icon: icon
        )
    }
}
