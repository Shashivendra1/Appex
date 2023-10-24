//
//  ChatCell.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//

import UIKit

class ChatCell: UITableViewCell {

    
    @IBOutlet weak var MessageSendingView: UIView!
    
    @IBOutlet weak var messageSendingLbl: UILabel!
    
    @IBOutlet weak var messageRecieveingView: UIView!
    
    
    @IBOutlet weak var messageRecievinglbl: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
        
    }

}
