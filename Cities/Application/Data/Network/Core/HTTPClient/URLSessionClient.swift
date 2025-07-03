//
//  URLSessionClient.swift
//  Cities
//
//  Created by Manuel Rodríguez Sebastián on 1/7/25.
//

import Foundation

final class URLSessionClient: HTTPClientContract {
    
    func get(from endpoint: APIRoute) async throws -> Data {
        guard let url = URL(string: endpoint.path) else {
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
