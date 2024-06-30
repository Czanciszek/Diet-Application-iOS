//
//  RequestMethod.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

enum RequestMethod {
    case get
    case post
    case put
    case delete
    
    func asHTTPMethod() -> String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        case .put:
            "PUT"
        case .delete:
            "DELETE"
        }
    }
}
