//
//  coachAcceptResponse.swift
//  APEX Mentality
//
//  Created by CTS on 02/08/23.
//

import Foundation

struct CoachAcceptResponse: Codable {
    let success, status: String?
    let data: CoachAcceptData?
    let message: String?
}

struct CoachAcceptData: Codable {
    let coachID, userID, mailMsg: String?

    enum CodingKeys: String, CodingKey {
        case coachID = "coach_id"
        case userID = "user_id"
        case mailMsg = "mail_msg"
    }
}

