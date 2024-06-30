//
//  AuthTokenStore.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import DietAppUtils

public protocol AuthTokenStorable {
    func getAuthToken() -> String?
    func storeAuthToken(token: String)
    func clearAuthToken()
}

public final class AuthTokenStore: AuthTokenStorable {
    
    public func getAuthToken() -> String? {
        KeychainManager.shared.getValue(forKey: "token")
    }
    
    public func storeAuthToken(token: String) {
        try? KeychainManager.shared.saveValue(token, forKey: "token")
    }
    
    public func clearAuthToken() {
        try? KeychainManager.shared.deleteValue(forKey: "token")
    }
}

extension DIContainer {
    public var authTokenStore: AuthTokenStorable {
        get { Self[AuthTokenStoreKey.self] }
        set { Self[AuthTokenStoreKey.self] = newValue }
    }
}

private struct AuthTokenStoreKey: InjectionKey {
    static var currentValue: AuthTokenStorable = AuthTokenStore()
}
