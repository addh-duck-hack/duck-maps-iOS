//
//  LoginResponse.swift
//  Maxi Taxi
//
//  Created by Gerardo Jacobo Luna on 30/01/25.
//

import Foundation
// MARK: - LoginResponse
class LoginResponse: Codable {
    let token, id, message: String

    init(token: String, id: String, message: String) {
        self.token = token
        self.id = id
        self.message = message
    }
}
extension LoginResponse {
    static var tokenKey = "TOKEN"
    static func getToken(_ saveToken: LoginResponse){
        do {
            let dataToken = try JSONEncoder().encode(saveToken)
            UserDefaults.standard.set(dataToken, forKey: self.tokenKey)
        } catch {
            debugPrint(error)
        }
    }
}
