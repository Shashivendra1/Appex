//
//  ChangePasswordValidation.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
struct ChangePasswordValidation {
    
    func validate(request: ChangePasswordRequest) -> ValidationResult {
        
        let emptyResult = checkForEmpty(request: request)
        if emptyResult.isEmpty{
            return ValidationResult(success: false, error: emptyResult.error)
        }
        
        let validationResult = checkForValidData(request: request)
        if !validationResult.isValid{
            return ValidationResult(success: false, error: validationResult.error)
        }
        
        return ValidationResult(success: true, error: nil)
    }
    
    private func checkForEmpty(request: ChangePasswordRequest) -> (isEmpty: Bool, error: ChangePasswordError?){
        
        if request.oldPassword!.isEmpty{
            return (true, .enterOldPassword)
        }
        
        if request.newPassword!.isEmpty{
            return (true, .enterNewPassword)
        }
        
        if request.confirmPassword!.isEmpty{
            return (true, .enterConfirmPassword)
        }
        
        return (false, nil)
        
    }
    
    private func checkForValidData(request: ChangePasswordRequest) -> (isValid: Bool, error: RegistrationError?){
        
        if request.newPassword! != request.confirmPassword!{
            return (false, .matchPasswords)
        }
        
//        if !request.newPassword!.isValidPassword(){
//            return (false, .invalidPassword)
//        }
        
        return (true, nil)
    }
     
}
