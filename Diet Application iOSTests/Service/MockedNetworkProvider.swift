//
//  MockedNetworkProvider.swift
//  Diet Application iOSTests
//
//  Created by Franciszek Czana on 29/06/2024.
//

@testable import Diet_Application_iOS

struct MockedNetworkProvider: NetworkProviding {
    func performURLRequest<T: Decodable>(apiRequest: APIRequest) async throws -> T {
        print("Data requested using the `MockedNetworkProvider`")
        throw APIError.errorWIP
    }
}
