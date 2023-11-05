//
//  ReceiverCell.swift
//  APEX Mentality
//kkkk
//  Created by CTS on 08/08/23.
//
//import UIKit
//
//class ReceiverCell: UIViewController {
//
//
//    @IBOutlet weak var lblTime: UILabel!
//    @IBOutlet weak var lblDate: UILabel!
//    @IBOutlet weak var lblMessage: UILabel!
//    @IBOutlet weak var messageView: UIView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//
//}

import UIKit
class ReceiverCell: UITableViewCell {
        var message: Message?{
        didSet{
        guard let message = self.message else { return }
            if message.timestamp != nil {
                
                if message.timestamp?.count != 10 {
                    let timeStamp = Date(timeIntervalSince1970: TimeInterval(message.timestamp!)! / 1000)
                    
                    self.lblTime.text = timeStamp.convertTimeInterval()
                    self.lblDate.text = timeStamp.convertTimeInterval(format: "MMM d, yyyy")
                    
                }else{
                    let timeStamp = Date(timeIntervalSince1970: TimeInterval(message.timestamp!)!)
                    
                    self.lblTime.text = timeStamp.convertTimeInterval()
                    self.lblDate.text = timeStamp.convertTimeInterval(format: "MMM d, yyyy")
                }
                self.lblMessage.text = message.content
            }
        }
    }
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        messageView.roundRadius(options: [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner], cornerRadius: 30)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        messageView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft], radius: 30)
    }

}
