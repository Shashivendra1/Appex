//
//  LoginValidation.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
struct LoginValidation{
    
    func validate(request: LoginRequest) -> ValidationResult{
        
        let emptyResult = checkFoEmpty(request: request)
        if emptyResult.isEmpty == true{
            return ValidationResult(success: false, error: emptyResult.error)
        }
        
        let validationResult = checkForValidData(request: request)
        if validationResult.isValid == false{
            return ValidationResult(success: false, error: validationResult.error)
        }
        
        return ValidationResult(success: true, error: nil)
        
    }
    
    private func checkFoEmpty(request: LoginRequest) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.email!.isEmpty{
            return (true, RegistrationError.emptyEmail)
        }
        
        if request.password!.isEmpty{
            return (true, RegistrationError.emptyPassword)
        }
        
        return (false, nil)
        }
    
    private func checkForValidData(request: LoginRequest) -> (isValid: Bool, error: RegistrationError?) {
        
        if !request.email!.isValidEmail(){
            return (false, RegistrationError.invalidEmail)
        }
        
//        if !request.password!.isValidPassword(){
//            return (false, RegistrationError.invalidPassword)
//        }
        
        return (true, nil)
        
    }
}

