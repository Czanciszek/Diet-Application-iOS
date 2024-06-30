//
//  AuthEncryptor.swift
//  Diet Application iOS
//
//  Created by Franciszek Czana on 29/06/2024.
//

import DietAppModel
import Foundation

enum AuthEncryptor {
    
    private static let publicKey = "PublicKey"
    private static let publicKeyExtension = "pem"
    
    static func encrypt(using userCredentials: UserCredentials) -> String? {
        
        guard
            let publicKey = publicKeyData(),
            let secKey = createSecKey(using: publicKey)
        else {
            return nil
        }
        
        return createEncryptedData(with: userCredentials, secKey: secKey)?
            .base64EncodedString()
    }
    
    private static func publicKeyData() -> NSData? {
        
        let fileURL = Bundle.module.url(
            forResource: publicKey,
            withExtension: publicKeyExtension)
        
        guard
            let fileURL,
            let jsonData = try? Data(contentsOf: fileURL)
        else {
            return nil
        }
        
        let publicKey = String(decoding: jsonData, as: UTF8.self)
            .sanitizedKey()
        
        return NSData(
            base64Encoded: publicKey,
            options: .ignoreUnknownCharacters)
    }
    
    private static func createSecKey(using publicKey: NSData) -> SecKey? {
        let attributes: [NSString: AnyObject] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass: kSecAttrKeyClassPublic
        ]
        
        return SecKeyCreateWithData(
            publicKey as CFData,
            attributes as CFDictionary,
            nil)
    }
    
    private static func createEncryptedData(
        with userCredentials: UserCredentials,
        secKey: SecKey
    ) -> Data? {
        
        let encryptedData = SecKeyCreateEncryptedData(
            secKey,
            .rsaEncryptionPKCS1,
            userCredentials.asData() as CFData,
            nil)
        
        return encryptedData as? Data
    }
}

private extension String {
    func sanitizedKey() -> String {
        self
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "-----END PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "\n", with: "")
    }
}

private extension UserCredentials {
    func asData() -> Data {
        let joined = [login, password].joined(separator: ":")
        return Data(joined.utf8)
    }
}
