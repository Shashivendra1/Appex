//
//  ResetPasswordValidation.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
struct ResetPasswordValidation {
    
    func validate(request: ResetPasswordRequest) -> ValidationResult{
        
        let emptyResult = checkForEmpty(request: request)
        if emptyResult.isEmpty{
            return ValidationResult(success: false, error: emptyResult.error)
        }
        
        let validResult = checkForValidData(request: request)
        if !validResult.isValid{
            return ValidationResult(success: false, error: validResult.error)
        }
        
        return ValidationResult(success: true, error: nil)
        
    }
    
    private func checkForEmpty(request: ResetPasswordRequest) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.email!.isEmpty{
            return (true, .emptyEmail)
        }
        
        return (false, nil)
        
    }
    
    private func checkForValidData(request: ResetPasswordRequest) -> (isValid: Bool, error: RegistrationError?){
        
        if !request.email!.isValidEmail(){
            return (false, .invalidEmail)
        }
        
        return (true, nil)
        
    }
    
}
