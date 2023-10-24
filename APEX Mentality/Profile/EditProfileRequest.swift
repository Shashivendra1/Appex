//
//  EditProfileRequest.swift
//  APEX Mentality
//
//  Created by CTS on 26/09/23.
//

import Foundation
struct EditProfileRequest: Codable {
    let userID, name, phone , location: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, phone
        case location
    }
}
