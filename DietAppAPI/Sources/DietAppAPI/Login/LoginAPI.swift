//
//  LoginAPI.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import DietAppModel
import DietAppUtils

public final class LoginAPI {
    
    @Inject(\.networkProvider) private var networkProvider
    
    public init() { }
    
    public func authorize(using userCredentials: UserCredentials) async throws -> LoginResponse {
        
        let apiRequest = LoginRequest(userCredentials: userCredentials)
        
        return try await networkProvider.performURLRequest(apiRequest: apiRequest)
    }
}
