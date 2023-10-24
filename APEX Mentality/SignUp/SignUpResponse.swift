//
//  SignUpResponse.swift
//  APEX Mentality
//
//  Created by CTS on 17/07/23.
//

import Foundation
// MARK: - Welcome4
struct SignUpResponse: Decodable {
    let success, status: String?
    let data: SignUpData?
    let message: String?
}

// MARK: - DataClass
struct SignUpData : Decodable {
    let name: String?
    let userID: Int?
    let email, phone: String?
        enum CodingKeys: String, CodingKey {
        case name
        case userID = "user_id"
        case email, phone
    }
}
