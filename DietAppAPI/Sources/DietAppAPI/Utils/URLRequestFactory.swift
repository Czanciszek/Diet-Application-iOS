//
//  URLRequestFactory.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 30/06/2024.
//

import Foundation

enum URLRequestFactory {
    
    private static let baseURLString = "http://192.168.1.224:8080/api"
    
    static func create(apiRequest: APIRequest) throws -> URLRequest {
        
        guard let url = createURL(apiRequest: apiRequest) else {
            throw APIError.errorWIP
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.method.asHTTPMethod()
        set(urlRequest: &urlRequest, header: apiRequest.header)
        
        return urlRequest
    }
    
    private static func createURL(apiRequest: APIRequest) -> URL? {
        var components = URLComponents(string: baseURLString)
        
        if let path = apiRequest.path {
            components?.path.append(path)
        }
        
        return components?.url
    }
}

extension URLRequestFactory {
    static func set(urlRequest: inout URLRequest, header: URLHeader) {
        set(urlRequest: &urlRequest, keyValue: header.authEncrypt)
        set(urlRequest: &urlRequest, keyValue: header.authorization)
        set(urlRequest: &urlRequest, keyValue: header.contentType)
    }
    
    private static func set<T: KeyValue>(urlRequest: inout URLRequest, keyValue: T?) {
        if let keyValue {
            urlRequest.setValue(
                keyValue.value,
                forHTTPHeaderField: keyValue.key)
        }
    }
}
