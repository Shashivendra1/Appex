//
//  ContactUsValidations.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

//import Foundation
//
//struct ContactUsValidation {
//        func validate(request: ContactUsRequest) -> ValidationResult{
//        
//        let emptyResult = checkForEmpty(request: request)
//        if emptyResult.isEmpty{
//            return ValidationResult(success: false, error: emptyResult.error)
//        }
//        
//        let validResult = checkForValidData(request: request)
//        
//        if validResult.isValid == false{
//            return ValidationResult(success: false, error: validResult.error)
//        }
//        
//        return ValidationResult(success: true, error: nil)
//    }
//    
//    func checkForEmpty(request: ContactUsRequest) -> (isEmpty: Bool, error: RegistrationError?){
//        
//        if request.name!.isEmpty{
//            return (true, .emptyName)
//        }
//        
//        if request.phone!.isEmpty{
//            return (true, .emptyPhone)
//        }
//        
//        if request.email!.isEmpty{
//            return (true, .emptyEmail)
//        }
//        
//        if request.message!.isEmpty{
//            return (true, .emptyMessage)
//        }
//        return (false, nil)
//        
//    }
//    
//    func checkForValidData(request: ContactUsRequest) -> (isValid: Bool, error: RegistrationError?){
//        
//        if !request.email!.isValidEmail(){
//            return (false, .invalidEmail)
//        }
//        return (true, nil)
//        
//    }
//    
//}
