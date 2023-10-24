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
           // print(message.timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            if let date = dateFormatter.date(from: message.timestamp ?? "") {
               // self.lblTime.text = date.convertTimeInterval()
              //  self.lblDate.text = date.convertTimeInterval(format: "MMM d, yyyy")
              //  print(date)
            } else {
                print("Error: Unable to convert timestamp to Date")
            }
            
//            let timeStamp = Date(timeIntervalSince1970: TimeInterval(message.timestamp!)! / 1000)
//            self.lblTime.text = timeStamp.convertTimeInterval()
//            self.lblDate.text = timeStamp.convertTimeInterval(format: "MMM d, yyyy")
            }
            self.lblMessage.text = message.content
            
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
