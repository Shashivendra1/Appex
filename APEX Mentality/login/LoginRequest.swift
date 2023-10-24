//
//  LoginRequest.swift
//  APEX Mentality
//
//  Created by CTS on 19/07/23.
//

import Foundation
struct LoginRequest: Encodable {
    var  name , email,password, fcm_key,device, login_type , profilePC: String?
    var confirmPassword: String?
    
    enum CodingKeys: String, CodingKey {
        case email, password, fcm_key, device , login_type
        case confirmPassword = "confirm_password"
    }
}

