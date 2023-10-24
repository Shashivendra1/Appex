//
//  NotificationResponse.swift
//  APEX Mentality
//
//  Created by CTS on 28/07/23.
//

import Foundation
struct NotificationResponse: Codable {
    let success, status: String?
    let data: [NotificationData]?
    let message: String?
}

struct NotificationData: Codable {
    let clientID, clientName: String?
    let clientStatus: ClientStatus?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientName = "client_name"
        case clientStatus = "client_status"
        case profileImage = "profile_image"
    }
}

enum ClientStatus: String, Codable {
    case approved = "Approved"
    case pending = "Pending"
    case rejected = "Rejected"
}
