//
//  coachListResponse.swift
//  APEX Mentality
//
//  Created by CTS on 28/07/23.
//

import Foundation

// MARK: - Welcome
struct coachListResponse: Codable {
    let success, status: String
    let data: [coachListData]
}

// MARK: - Datum
struct coachListData: Codable {
    let userID: Int
    let email, name, phone, designation: String
    let profilePic: String
    let request: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email, name, phone, designation
        case profilePic = "profile_pic"
        case request
    }
}
