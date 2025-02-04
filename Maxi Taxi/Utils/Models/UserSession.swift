//
//  UserSession.swift
//  Maxi Taxi
//
//  Created by Gerardo Jacobo Luna on 31/01/25.
//

import Foundation
// MARK: - UserSession
class UserSession: Codable {
    let mail, pass: String

    init(mail: String, pass: String) {
        self.mail = mail
        self.pass = pass
    }
}
