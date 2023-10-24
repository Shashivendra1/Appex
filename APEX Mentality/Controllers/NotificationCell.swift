//
//  NotificationCell.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//

import UIKit

class NotificationCell: UITableViewCell {
   
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellView.layer.cornerRadius = 10
        profileImg.clipsToBounds = true
        profileImg.cornerRadius = 25
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
