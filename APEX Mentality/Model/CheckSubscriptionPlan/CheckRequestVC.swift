//
//  CheckRequestVC.swift
//  APEX Mentality
//
//  Created by CTS on 18/10/23.
//


import Foundation
struct CheckSubscriptionPlanRequest: Codable {
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
