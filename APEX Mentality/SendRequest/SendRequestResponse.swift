//
//  SendRequestResponse.swift
//  APEX Mentality
//
//  Created by CTS on 28/07/23.
//

import Foundation


struct sendRequestResponse: Codable {
    let success, status: String?
    let data: sendRequestDataClass?
    let message: String?
}

// MARK: - DataClass
struct sendRequestDataClass: Codable {
    let userid: String?
    let coacheid: Int?
    let coachName: String?

    enum CodingKeys: String, CodingKey {
        case coacheid
        case userid
        case coachName = "coach_name"
    }

}


