//
//  ChangePasswordRequest.swift
//  APEX Mentality
//
//  Created by CTS on 20/07/23.
//

import Foundation
struct ChangePasswordRequest: Encodable {
    var userID, oldPassword, newPassword, confirmPassword: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case oldPassword = "old_password"
        case newPassword = "new_password"
        case confirmPassword = "confirm_password"
    }
}
