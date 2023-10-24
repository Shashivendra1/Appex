//
//  ChatListCell.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 30/06/23.
//

import UIKit

class ChatListCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var chatImg: UIImageView!
    @IBOutlet weak var chatName: UILabel!
    @IBOutlet weak var chatMessageLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 20
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
