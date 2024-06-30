//
//  NetworkProvider.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import DietAppUtils
import Foundation

protocol NetworkProviding {
    func performURLRequest<T: Decodable>(apiRequest: APIRequest) async throws -> T
}

final class NetworkProvider: NetworkProviding {
    
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()
    
    func performURLRequest<T: Decodable>(apiRequest: APIRequest) async throws -> T {
        
        let urlRequest = try URLRequestFactory.create(apiRequest: apiRequest)
        
        // Log URL Request
        
        let (data, response) =  try await session.data(for: urlRequest)
        
        // Log URL Response
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.errorWIP
        }
        
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.errorWIP
        }
        
        return try decoder.decode(T.self, from: data)
    }
}

extension DIContainer {
    var networkProvider: NetworkProviding {
        get { Self[NetworkProviderKey.self] }
        set { Self[NetworkProviderKey.self] = newValue }
    }
}

private struct NetworkProviderKey: InjectionKey {
    static var currentValue: NetworkProviding = NetworkProvider()
}
