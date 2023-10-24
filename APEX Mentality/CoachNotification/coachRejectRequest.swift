//
//  coachRejectRequest.swift
//  APEX Mentality
//
//  Created by CTS on 02/08/23.
//

import Foundation
struct CoachRejectRequest: Codable {
    let coachID, userID, status: String

    enum CodingKeys: String, CodingKey {
        case coachID = "coach_id"
        case userID = "user_id"
        case status
    }
}

