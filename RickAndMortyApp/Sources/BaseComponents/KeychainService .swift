//
//  KeychainService .swift
//  RickAndMortyApp
//
//  Created by Алсу Хайруллина on 02.11.2023.
//

import Foundation
import Security

// MARK: Keychain status
enum KeychainStatus {
    case success
    case error
}

// MARK: Keychain Protocols
protocol KeychainServiceProtocols: AnyObject {
    func signUp(username: String, password: String) -> KeychainStatus
    func logIn(username: String, password: String) -> KeychainStatus
    func isLoggedIn() -> Bool
    func setCurrentUser()
    func logOut()
}

public final class KeychainService: KeychainServiceProtocols {
    
    /// Saves user's username and password to Keychain and returns status. Also sets current user.
    func signUp(username: String, password: String) -> KeychainStatus {
        let password = password.data(using: String.Encoding.utf8)!
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: username,
                                    kSecValueData as String: password]
        if SecItemAdd(query as CFDictionary, nil) == noErr {
            print("User saved successfully in the keychain")
            setCurrentUser()
            return KeychainStatus.success
        } else {
            print("Something went wrong trying to save the user in the keychain")
            return KeychainStatus.error
        }
    }
    
    /// Logs user in if password parametr exist for a specific username in Keychain, returns status. Also sets current user.
    func logIn(username: String, password: String) -> KeychainStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            if let existingItem = item as? [String: Any],
               let passwordData = existingItem[kSecValueData as String] as? Data,
               let passwordValue = String(data: passwordData, encoding: .utf8)
            {
                if passwordValue == password {
                    setCurrentUser()
                    return KeychainStatus.success
                }
            }
        } else {
            print("Something went wrong trying to find the user in the keychain")
        }
        return KeychainStatus.error
    }
    
    /// Sets current user after logging in/signing up by changing isLoggedIn value to true.
    func setCurrentUser() {
        let currentUser = UserDefaults.standard
        currentUser.set(true, forKey: "isLoggedIn")
        currentUser.synchronize()
    }
    
    /// Checks if there is logged user.
    func isLoggedIn() -> Bool {
        let userDefault = UserDefaults.standard
        let currentUser = userDefault.bool(forKey: "isLoggedIn")
        if (currentUser) {
            return false
        } else {
            return true
        }
    }
    
    /// Logs user out and change isLoggedIn value to false.
    func logOut() {
        let currentUser = UserDefaults.standard
        currentUser.set(false, forKey: "isLoggedIn")
        currentUser.synchronize()
    }
}
