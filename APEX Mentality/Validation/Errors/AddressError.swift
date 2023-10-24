//
//  AddressError.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//
//
//import Foundation
//
//enum AddressError: HamptonError, LocalizedError{
//    
//    case emptyFirstName
//    case emptyLastName
//    case emptyPhone
//    case emptyPin
//    case emptyCountry
//    case emptyCity
//    case emptyState
//    case emptyAddress
//    
//    var errorDescription: String?{
//        
//        switch self {
//        
//        case .emptyFirstName:
//            return NSLocalizedString("Please enter first name", comment: "")
//        case .emptyLastName:
//            return NSLocalizedString("Please enter last name", comment: "")
//        case .emptyPhone:
//            return NSLocalizedString("Please enter phone number", comment: "")
//        case .emptyPin:
//            return NSLocalizedString("Please enter pin", comment: "")
//        case .emptyCountry:
//            return NSLocalizedString("Please enter country", comment: "")
//        case .emptyCity:
//            return NSLocalizedString("Please enter city", comment: "")
//        case .emptyState:
//            return NSLocalizedString("Please enter state", comment: "")
//        case .emptyAddress:
//            return NSLocalizedString("Please enter address", comment: "")
//        }
//        
//    }
//    
//}
