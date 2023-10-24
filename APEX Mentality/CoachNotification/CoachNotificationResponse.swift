//
//  CoachNotificationResponse.swift
//  APEX Mentality
//
//  Created by CTS on 02/08/23.
//

import Foundation
struct CoachNotificationResponse: Codable {
    let success, status: String?
    let data: [coachNotificationData]
    let message: String?
}

struct coachNotificationData: Codable {
    let clientID, clientName: String?
    let clientStatus: String?
    let profileImage: String?
    
   
    enum CodingKeys: String, CodingKey {
        case clientID = "client_id"
        case clientName = "client_name"
        case clientStatus = "client_status"
        case profileImage = "profile_image"
    }
}

enum ClientStatuss: String, Codable {
    case approved = "Approved"
    case pending = "Pending"
    case rejected = "Rejected"
}
