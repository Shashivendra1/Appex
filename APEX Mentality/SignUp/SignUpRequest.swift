//
//  SignUpRequest.swift
//  APEX Mentality
//
//  Created by CTS on 17/07/23.
//

import Foundation


struct SignUpRequest: Encodable {
    var name,lastName, email, phone, password: String?
    var confirmPassword: String?

    enum CodingKeys: String, CodingKey {
        case name, email, phone, password
        case confirmPassword = "confirm_password"
    }
}
