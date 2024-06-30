//
//  APIRequest.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

protocol APIRequest {
    var header: URLHeader { get }
    var path: String? { get }
    var method: RequestMethod { get }
}

extension APIRequest {
    
    var path: String? {
        nil
    }
    
    var method: RequestMethod {
        .get
    }
}
