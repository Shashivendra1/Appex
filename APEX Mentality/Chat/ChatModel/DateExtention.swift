//
//  DateExtention.swift
//  APEX Mentality
//
//  Created by CTS on 10/08/23.
//

import Foundation

extension Date {
    func convertTimeInterval(format: String? = "h:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
    //        dateFormatter.timeZone = TimeZone(abbreviation: "Australia/Sydney")
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
}
