//
//  LoginRequest.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import DietAppModel

struct LoginRequest: APIRequest {
    
    let encryptedData: String
    
    init(userCredentials: UserCredentials) {
        self.encryptedData = AuthEncryptor.encrypt(using: userCredentials) ?? ""
    }
    
    var header: URLHeader {
        URLHeader(
            authEncrypt: .encrypted(data: encryptedData),
            contentType: .applicationJson)
    }
    
    var path: String? {
        "/v2/auth/login"
    }
}
