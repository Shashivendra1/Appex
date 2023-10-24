//
//  ApexAlertView.swift
//  APEX Mentality
//
//  Created by CTS on 19/07/23.
//

import Foundation
import UIKit
class HamptonAlertView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func applyLayout() {
        backgroundColor = .clear
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.text = ""
        
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textColor = UIColor.darkGray
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.text = ""
        
    }
    
    class func instantiateFromNib() -> HamptonAlertView {
        return Bundle.main.loadNibNamed("HamptonAlertView", owner: nil, options: nil)!.first as! HamptonAlertView
    }
}
