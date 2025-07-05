//
//  URLSessionClient.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation

final class URLSessionClient: HTTPClientContract {
    
    func get(from endpoint: APIRouteContract, parameters: [String: String]? = nil) async throws -> Data {
        var urlString = endpoint.path
        
        if let parameters = parameters, !parameters.isEmpty {
            let queryString = parameters.map { "\($0.key)=\($0.value)" }
                                        .joined(separator: "&")
            urlString.append("?\(queryString)")
        }

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw NetworkError.networkError
        }
    }

}
