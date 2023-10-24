//
//  LoginResponse.swift
//  APEX Mentality
//
//  Created by CTS on 19/07/23.
//

import Foundation
struct LoginResponse: Decodable {
    let success, status: String?
    let data: LoginData?
    let message: String?
}

// MARK: - DataClass
struct LoginData: Decodable {
    let name: String?
    let userID: Int?
    let email, userRole, phone, fcmKey: String?
    let profilePC: String?

    enum CodingKeys: String, CodingKey {
        case name
        case userID = "user_id"
        case email
        case userRole = "user_role"
        case phone
        case fcmKey = "fcm_key"
        case profilePC = "profile_pc"
    }
    
}
