//
//  coachRejectResponse.swift
//  APEX Mentality
//
//  Created by CTS on 02/08/23.
//

import Foundation
struct CoachRejectResponse: Codable {
    let success, status: String
    let data: CoachRejectData
    let message: String
}

struct CoachRejectData: Codable {
    let couchID, userID, mailMsg: String
    enum CodingKeys: String, CodingKey {
        case couchID = "couch_id"
        case userID = "user_id"
        case mailMsg = "mail_msg"
    }
}

