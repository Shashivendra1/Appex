//
//  SignupValidation.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//


import Foundation
struct SignUpValidation{
        func validate(request: SignUpRequest) -> ValidationResult {
        let emptyResult = checkForEmpty(request: request)
        if emptyResult.isEmpty{
            return ValidationResult(success: false, error: emptyResult.error)
        }
        
        let validResult = checkForValidData(request: request)
        
        if validResult.isValid ==  false{
            return ValidationResult(success: validResult.isValid, error: validResult.error)
        }
        
        return ValidationResult(success: true, error: nil)
    }
    
    private func checkForEmpty(request: SignUpRequest) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.name!.isEmpty{
            return (true, .emptyName)
        }
        
        if request.email!.isEmpty{
            return (true, .emptyEmail)
        }
        
        if request.phone!.isEmpty{
            return (true, .emptyPhone)
        }
        
        if request.password!.isEmpty{
            return (true, .emptyPassword)
        }
        
        if request.confirmPassword!.isEmpty{
            return (true, .emptyConfirmPassword)
        }
         return (false, nil)
    }
    
    private func checkForValidData(request: SignUpRequest) -> (isValid: Bool, error: RegistrationError?) {
        
        if !request.email!.isValidEmail(){
            return (false, .invalidEmail)
        }
        
//        if !request.password!.isValidPassword(){
//            return (false, .invalidPassword)
//        }
        
        if request.password! != request.confirmPassword!{
            return (false, .matchPasswords)
        }
        
        return (true, nil)
    }
    
}
