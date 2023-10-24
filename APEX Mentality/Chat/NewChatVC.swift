//
//  NewChatVC.swift
//  APEX Mentality
//
//  Created by CTS on 08/08/23.
//

import UIKit
import MobileCoreServices
import FirebaseAuth
import FirebaseDatabase
import SwiftyJSON
import FirebaseStorage

struct NotificationKeys {
    static let MESSAGE = "Message"
}

class NewChatVC: UIViewController , UIGestureRecognizerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var customNavigationBar: CustomNavigationBar!
    @IBOutlet weak var sendMsgTxtView: UITextView!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tblView.delegate = self
//        self.tblView.dataSource = self
    }
    
  
        
 
}
    
    
