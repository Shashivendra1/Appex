//
//  coachMessageCell.swift
//  APEX Mentality
//
//  Created by CTS on 31/07/23.
//

import UIKit
class coachMessageCell: UITableViewCell {
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var chatMessage: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var timeLbl: UILabel!
    
      override func awakeFromNib() {
        super.awakeFromNib()
          chatImage.layer.masksToBounds = false
          chatImage.layer.cornerRadius = chatImage.frame.size.height/2
          chatImage.clipsToBounds = true
          
          cellView.cornerRadius = 12
          cellView.layer.borderWidth = 2
          cellView.layer.borderColor = UIColor(red: 240/255, green: 234/255, blue: 242/255, alpha: 1).cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
    }

}

