//
//  ProfileResponse.swift
//  APEX Mentality
//
//  Created by CTS on 20/07/23.
//

import Foundation
// MARK: - Profile
struct ProfileResponse: Decodable {
    let success, status: String?
    let data: ProfileData?
    let message: String?
}

// MARK: - ProfileClass
struct ProfileData: Decodable {
    let name, email, phone, profileImage: String?
    enum CodingKeys: String, CodingKey {
        case name, email, phone
        case profileImage = "profile_image"
    }
}
