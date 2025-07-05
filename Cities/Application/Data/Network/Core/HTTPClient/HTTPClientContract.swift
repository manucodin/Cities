//
//  HTTPClientContract.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 2/7/25.
//

import Foundation

protocol HTTPClientContract {
    func get(from endpoint: APIRouteContract, parameters: [String: String]?) async throws -> Data
}
