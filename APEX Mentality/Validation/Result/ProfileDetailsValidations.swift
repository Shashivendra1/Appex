//
//  ProfileDetailsValidations.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
struct ProfileDetailsValidation {
    
    func validate(request: EditProfileRequest) -> ValidationResult {
        
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
    
    private func checkForEmpty(request: EditProfileRequest) -> (isEmpty: Bool, error: RegistrationError?){
        
        if request.name!.isEmpty{
            return (true, .emptyName)
        }
//
//        if request.email!.isEmpty{
//            return (true, .emptyEmail)
//        }
        
        if request.phone!.isEmpty{
            return (true, .emptyPhone)
        }
//
//        if request.location!.isEmpty{
//            return (true, .emptyLocation)
//        }
//
        return (false, nil)
    }
    
    private func checkForValidData(request: EditProfileRequest) -> (isValid: Bool, error: RegistrationError?){
        
//        if !request.email!.isValidEmail(){
//            return(false, .invalidEmail)
//        }
        
        return (true, nil)
    }
    
}
