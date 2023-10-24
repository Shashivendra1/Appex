//
//  coachMessageVC.swift
//  APEX Mentality
////  Created by CTS on 31/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class coachMessageVC: UIViewController {
    @IBOutlet weak var logoutView: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var profileMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let chatViewModel = ChatViewModel()
    var users = [FirebaseUser]()
   
    private let fdbRef = Database.database().reference()
   
        var comingFrom = ""
        override func viewDidLoad() {
        super.viewDidLoad()
         navigationController?.interactivePopGestureRecognizer?.isEnabled = false
         tableView.separatorStyle = .none
         profilePic.layer.cornerRadius = 10
         profilePic.layer.borderWidth = 1
         profilePic.layer.masksToBounds = false
         profilePic.layer.borderColor = UIColor.clear.cgColor
         profilePic.layer.cornerRadius = profilePic.frame.height/2
         profilePic.clipsToBounds = true
       
         
        print(users)
        let profileImg =  UserDefaults.standard.getProfile()
        if  profileImg != ""{
       
//           let profilePic = UserDefaults.standard.getProfile()
            self.profilePic.kf.setImage(with: URL(string:profileImg ?? ""   ))
            print(profilePic)
        }
          getUsersList()
        tableView.layer.cornerRadius = 20
        self.logoutView.layer.cornerRadius = 20
}
    
    override func viewWillAppear(_ animated: Bool) {
        getUsersList()
    }
        
    private func getUsersList(){
        print("Get users list")
        chatViewModel.getUsersList { (usersList) in
            self.users = usersList
            print(self.users)
            DispatchQueue.main.async {
                if self.users.count > 0 {
//                    self.emptyView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                } else {
//                    self.emptyView.isHidden = false
                    self.tableView.isHidden = true
                }

                //   self.hideLoading()
            }

        } onError: { (errorMessage) in
            print(errorMessage)
        }
    }
    
    @IBAction func onClickNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CoachNotificationVC") as! CoachNotificationVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onClickAdminChat(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.comingFrom =    "coachMessageVC"
        vc.toIDcomingFrom = "adminapex444"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
        
    @IBAction func onClickLogout(_ sender: UIButton) {
           showAlert()
    }
    func showAlert(){
        let alert = UIAlertController(title: "APEX Mentality App", message: "Are you sure you want to LogOut ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            UserDefaults.standard.setUserLoggedIn(false)
            let userId = UserDefaults.standard.getUserID()
            let userEmailId = UserDefaults.standard.getEmail()
            UserDefaults.standard.removeObject(forKey: userId ?? "")
            UserDefaults.standard.removeObject(forKey: userEmailId ?? "")
            UserDefaults.standard.removeObject(forKey: "userRole")
            
            UserDefaults.standard.removeObject(forKey:"LOGGED_IN")
            UserDefaults.standard.removeObject(forKey: "user_id")
            UserDefaults.standard.removeObject(forKey: "EMAIL")
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            //            self.deleteAccountApiCall()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true, completion: nil)
    }
}
    
extension coachMessageVC : UITableViewDelegate , UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
       return self.users.count
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coachMessageCell") as! coachMessageCell
        let info = self.users[indexPath.row]
        cell.chatName.text = info.name
   //   cell.timeLbl.text = info.timestamp
        if info.image != ""
        {
//           let profilePic = UserDefaults.standard.getProfile()
            cell.chatImage.kf.setImage(with: URL(string:info.image ?? ""   ))
            print(info.image)
        }
        
//        let timeStamp = Date(timeIntervalSince1970: TimeInterval(info.time!)! / 1000)
//        cell.timeLbl.text = timeStamp.convertTimeInterval()
//        print( cell.timeLbl.text)
        cell.chatName.text = info.name
        cell.chatMessage.text = info.lastMessage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let uidd = info.uid else {return}
        let vc  = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        let info = self.users[indexPath.row]
        vc.userName1 = info.name ?? ""
        vc.userType = "chat"
        vc.userID = info.uid ?? ""
        vc.comingFrom = "coachMessageVC"
//        vc.toId = info.uid ?? ""
//        vc.toIDcomingFrom = info.uid ?? ""
//        vc.userName = info.name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
