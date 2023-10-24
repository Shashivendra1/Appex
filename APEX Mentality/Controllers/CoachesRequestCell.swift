//
//  CoachesRequestCell.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//

import UIKit

class CoachesRequestCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var cellImg: UIImageView!
    
    @IBOutlet weak var requestNameLbl: UILabel!
    
    @IBOutlet weak var sendRequestLbl: UILabel!
    
    @IBOutlet weak var messageLbl: UILabel!
    
    @IBOutlet weak var sendRequestOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    self.sendRequestOutlet.layer.cornerRadius = 5
        self.cellView.layer.cornerRadius = 20
        self.cellImg.layer.cornerRadius = 25
        self.cellImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    
    
    
    
}
