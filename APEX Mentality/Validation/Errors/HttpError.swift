//
//  HttpError.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
enum HTTPError: HamptonError, LocalizedError {
    case incorrectData
    case badRequest
    case internetConnection
    
    var errorDescription: String?{
        switch self {
        case .incorrectData:
            return NSLocalizedString("Something bad happened on server side", comment: "")
        case .badRequest:
            return NSLocalizedString("Bad Request", comment: "")
        case .internetConnection:
            return NSLocalizedString("No Internet Connection", comment: "")
        }
    }
    
}
protocol HamptonError: Error{}

protocol CustomSegmentedControlDelegate:class {
    func change(to index:Int)
}

