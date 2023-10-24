//
//  ClientRejectRequest.swift
//  APEX Mentality
//
//  Created by CTS on 01/08/23.
//

import Foundation
struct ClientRejectRequest: Codable {
    let userID: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
    
}
