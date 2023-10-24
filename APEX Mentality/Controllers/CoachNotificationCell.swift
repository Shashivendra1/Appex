//
//  CoachNotificationCell.swift
//  APEX Mentality
//
//  Created by CTS on 31/07/23.
//

import UIKit
class CoachNotificationCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var statusLbl: UILabel!
        
    @IBOutlet weak var notificationImage: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var aceeptBtn: UIButton!
    
    @IBOutlet weak var rejectBtn: UIButton!
    
    @IBOutlet weak var cellView: UIView!
        
        override func awakeFromNib() {
        super.awakeFromNib()

            notificationImage.layer.masksToBounds = false
            notificationImage.layer.cornerRadius =  notificationImage.frame.size.height/2
            notificationImage.clipsToBounds = true
            
        cellView.layer.cornerRadius = 20
        aceeptBtn.layer.cornerRadius = 10
        rejectBtn.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
