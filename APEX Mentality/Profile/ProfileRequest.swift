//
//  ProfileRequest.swift
//  APEX Mentality
//
//  Created by CTS on 20/07/23.
//

import Foundation
struct ProfileRequest: Encodable {
    var userID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
