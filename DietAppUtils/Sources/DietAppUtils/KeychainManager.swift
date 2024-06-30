//
//  KeychainManager.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 29/06/2024.
//

import Foundation
import Security

public final class KeychainManager {
    
    public static let shared = KeychainManager()
    
    private init() {}

    enum KeychainError: Error {
        case duplicateEntry
        case unknown(OSStatus)
    }

    public func getValue(forKey key: String) -> String? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard
            status == errSecSuccess,
            let data = dataTypeRef as? Data
        else {
            return nil
        }
        
        return String(decoding: data, as: UTF8.self)
    }
    
    public func saveValue(_ value: String, forKey key: String) throws {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: Data(value.utf8),
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            break
        case errSecDuplicateItem:
            throw KeychainError.duplicateEntry
        default:
            throw KeychainError.unknown(status)
        }
    }
    
    public func deleteValue(forKey key: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        switch status {
        case errSecSuccess, errSecItemNotFound:
            break
        default:
            throw KeychainError.unknown(status)
        }
    }
}

