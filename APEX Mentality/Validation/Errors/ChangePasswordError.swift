//
//  ChangePasswordError.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
enum ChangePasswordError: HamptonError, LocalizedError {
    
    case enterOldPassword
    case enterNewPassword
    case enterConfirmPassword
    
    var errorDescription: String?{
        
        switch self {
        case .enterOldPassword:
            return NSLocalizedString("Please enter old password", comment: "")
        case .enterNewPassword:
            return NSLocalizedString("Please enter new password", comment: "")
        case .enterConfirmPassword:
            return NSLocalizedString("Please enter confirm password", comment: "")
        }
    }
}
