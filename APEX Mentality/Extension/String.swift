//
//  String.swift
//  APEX Mentality
//
//  Created by CTS on 19/07/23.
//

import Foundation
import UIKit
extension String{
    
    func isValidEmail() -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func isLengthValid(minLength: Int , maxLength: Int) -> Bool {
           return self.count >= minLength && self.count <= maxLength
       }
    
    func isValidPhone() -> Bool
    {
        let mobileRegEx = NSString(format:"[0-9]{%d}",10) as String
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", mobileRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool{
        if self.count >= 6 {
            return true
        }else{
            return false
        }
    }
    
    public var withoutHtml: String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return self
        }
        
        return attributedString.string
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let paragraphStyle = NSMutableParagraphStyle()
                        paragraphStyle.alignment = .left
            let content = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            
            content.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                   NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                   NSAttributedString.Key.foregroundColor: UIColor.white],
                                  range: NSMakeRange(0, content.length))
            
            return content
            
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}

