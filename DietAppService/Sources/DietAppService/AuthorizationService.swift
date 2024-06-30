//
//  AuthorizationService.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 29/06/2024.
//

import DietAppAPI
import DietAppModel
import DietAppUtils

public protocol AuthorizationProtocol {
    func authorize(using: UserCredentials) async throws
}

public final class AuthorizationService: AuthorizationProtocol {
    
    @Inject(\.authTokenStore) private var authTokenStore
    
    public init() { }
    
    public func authorize(using userCredentials: UserCredentials) async throws {
        let loginResponse = try await LoginAPI().authorize(using: userCredentials)
        authTokenStore.storeAuthToken(token: loginResponse.token)
    }
    
}

extension DIContainer {
    public var authorization: AuthorizationProtocol {
        get { Self[AuthorizationKey.self] }
        set { Self[AuthorizationKey.self] = newValue }
    }
}

private struct AuthorizationKey: InjectionKey {
    static var currentValue: AuthorizationProtocol = AuthorizationService()
}
