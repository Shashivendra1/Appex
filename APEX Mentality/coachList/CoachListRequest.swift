//
//  CoachListRequest.swift
//  APEX Mentality
//
//  Created by CTS on 28/07/23.
//



import Foundation
struct coachListRequest: Encodable {
    var userID, email, name, phone, designation , profilePic  , request: String?
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case email = "email"
        case name = "name"
        case phone = "phone"
        case designation = "designation"
        case profilePic = "profile_pic"
        case request = "request"
        
    }
}


