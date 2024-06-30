//
//  URLHeader.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

protocol KeyValue {
    var key: String { get }
    var value: String { get }
}

struct URLHeader {
    
    enum AuthEncrypt: KeyValue {
        
        case encrypted(data: String)
        
        var key: String {
            "AuthEncrypt"
        }
        
        var value: String {
            switch self {
            case .encrypted(let data):
                data
            }
        }
    }
    
    enum Authorization: KeyValue {
        
        case bearer(token: String)
        
        var key: String {
            "Authorization"
        }
        
        var value: String {
            switch self {
            case .bearer(let token):
                return "Bearer \(token)"
            }
        }
    }
    
    enum ContentType: KeyValue {
        
        case applicationJson
        
        var key: String {
            "Content-Type"
        }
        
        var value: String {
            "application/json"
        }
    }
    
    let authEncrypt: AuthEncrypt?
    let authorization: Authorization?
    let contentType: ContentType?
    
    init(
        authEncrypt: AuthEncrypt? = nil,
        authorization: Authorization? = nil,
        contentType: ContentType? = nil
    ) {
        self.authEncrypt = authEncrypt
        self.authorization = authorization
        self.contentType = contentType
    }
}

