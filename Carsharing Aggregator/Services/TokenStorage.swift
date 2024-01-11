//
//  TokenStorage.swift
//  Carsharing Aggregator
//
//  Created by Aleksandr Garipov on 11.01.2024.
//

import SwiftKeychainWrapper

protocol TokenStorageProtocol {
    func saveToken(_ token: String)
    func getToken() -> String?
    func deleteToken()
}

final class TokenStorage: TokenStorageProtocol {
    
    static let shared = TokenStorage()
    
    private init() {}
    
    private let tokenKey = "UserToken"

     func saveToken(_ token: String) {
         KeychainWrapper.standard.set(token, forKey: tokenKey)
     }

     func getToken() -> String? {
         return KeychainWrapper.standard.string(forKey: tokenKey)
     }

     func deleteToken() {
         KeychainWrapper.standard.removeObject(forKey: tokenKey)
     }
}
