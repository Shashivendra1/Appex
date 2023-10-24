//
//  ChatListVC.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 30/06/23.
//

import UIKit

class ChatListVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
 
  
    @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell") as! ChatListCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
//        let vc  = storyboard.instantiateViewController(withIdentifier: "NewChatVC") as! NewChatVC
        
        
        let vc  = storyboard.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
   
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
       @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
