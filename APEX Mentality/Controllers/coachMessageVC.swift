//
//  coachMessageVC.swift
//  APEX Mentality
////  Created by CTS on 31/07/23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MBProgressHUD

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
        
        getChatUserList()
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        tableView.separatorStyle = .none
        profilePic.layer.cornerRadius = 10
        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.clear.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
        
        
        // print(users)
        let profileImg =  UserDefaults.standard.getProfile()
        if  profileImg != ""{
            
            //           let profilePic = UserDefaults.standard.getProfile()
            self.profilePic.kf.setImage(with: URL(string:profileImg ?? ""   ))
            print(profilePic)
        }
        
        tableView.layer.cornerRadius = 20
        self.logoutView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // getUsersList()
        
    }
        
    private func getUsersList(){
        DispatchQueue.main.async {
        self.showLoader()
        }
        print("Get users list")
        chatViewModel.getUsersList { (usersList) in
            self.users = usersList
            print(self.users)
            DispatchQueue.main.async {
                if self.users.count > 0 {
                    DispatchQueue.main.async {
                    self.hideLoader()
                    }
//                    self.emptyView.isHidden = true
                    self.tableView.isHidden = false
                    self.tableView.reloadData()
                } else {
                    
//                    self.emptyView.isHidden = false
                    self.tableView.isHidden = true
                }
                DispatchQueue.main.async {
                    self.hideLoader()
                }
                //   self.hideLoading()
            }

        } onError: { (errorMessage) in
            print(errorMessage)
        }
    }
    
    
    func getChatUserList() {
        //var users = [FirebaseUser]()
        var clientType = ""
    
        let fdbRef = Database.database().reference()
        guard let userId = UserDefaults.standard.getUserID() else { return  }
        
        let userType = UserDefaults.standard.getUserRole()
        
        if userType?.lowercased() == "client"{
            clientType = "asignCoach"
        }else{
            clientType = "users"
        }
        //fdbRef.child("users").child(userId).observeSingleEvent(of:.value) { snapshot,data in
        fdbRef.child("users").child(userId).observe( .value) { (snapshot) in
            if snapshot.exists(){
                print(snapshot)
                var fcm_key = ""
                var email = ""
                var name = ""
                if let dict = snapshot.value as? NSDictionary, let postContent = dict["fcmKey"] as? String {
                    fcm_key = postContent
                } else {

                }
                if let dict = snapshot.value as? NSDictionary, let postContent = dict["email"] as? String {
                    email = postContent
                } else {

                }
                if let dict = snapshot.value as? NSDictionary, let postContent = dict["userName"] as? String {
                    name = postContent
            } else {

           }
             let enumrator = snapshot.children
                while let snap = enumrator.nextObject() as? DataSnapshot{
                    if let userDict = snap.value as? [String: AnyObject] {
                       // print(userDict)
                        self.users.removeAll()
                        for (key, value) in userDict {
                            print("key is - \(key) and value is - \(value)")
                            let metaData = value["metaData"] as? NSMutableDictionary
                            let user = metaData?["user"] as? NSMutableDictionary
                            let vendor = metaData?["name"] as? NSMutableDictionary
                            if key != "adminapex444"{
                                //                                let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as? String, name: user?["name"] as? String, image: value["image"] as? String, fcmKey: fcm_key, timestamp: value["timestamp"] as? String, time: value["time"] as? String)
                             let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as? String, name: user?["name"] as? String, image: value["image"] as? String, fcmKey: fcm_key, timestamp: value["timestamp"] as? String, time: value["time"] as? String)
                                
                                
                               // let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as? String, name: value["name"] as? String, image: value["image"] as? String, fcmKey: fcm_key, timestamp: value["timestamp"] as? String, time: value["time"] as? String)
                                self.users.append(userInstance)
                            }
                        } // End for loop
                        print(self.users)
                        
                    }
                }
                
                if self.users.count != 0 {
                    DispatchQueue.main.async {
                  
                        self.users = self.sortUsersListByTime(usersArray: self.users)
                       
                        self.tableView.reloadData()
                    }
                    
//                    self.users =  self.users.sorted{$0.timestamp! < $1.timestamp!} // Sorting messages according to date
//                    self.tableView.reloadData()
                    
//                    var timeArr = [String]()
//                    for item in self.users {
//                        if item.timestamp == nil {
//                            timeArr.append("nil")
//                        }else{
//                            timeArr.append(item.timestamp!)
//                        }
//                    }
//                    if timeArr.contains("nil"){
//                        print("nil nil ")
//                        self.tableView.reloadData()
//                    }else{
//                        print("it have value")
//                        self.users =  self.users.sorted{$0.timestamp! > $1.timestamp!} // Sorting messages according to date
//                        self.tableView.reloadData()
//
//                    }

                }else{
                    print(" no dattaa")
                }
               
            }
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
    
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    // Hide the loader
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    
    func showAlert(){
        DispatchQueue.main.async {
            self.showLoader()
        }
        let alert = UIAlertController(title: "APEX Mentality App", message: "Are you sure you want to LogOut ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            DispatchQueue.main.async {
                self.hideLoader()
            }
            
            UserDefaults.standard.setUserLoggedIn(false)
            let userId = UserDefaults.standard.getUserID()
            let userEmailId = UserDefaults.standard.getEmail()
            UserDefaults.standard.removeObject(forKey: userId ?? "")
            UserDefaults.standard.removeObject(forKey: userEmailId ?? "")
            UserDefaults.standard.saveUserRole(userRole:"1")
            //UserDefaults.standard.removeObject(forKey: "userRole")
            
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
            DispatchQueue.main.async {
                self.hideLoader()
            }
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true, completion: nil)
    }
       
    
}
    
extension coachMessageVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coachMessageCell") as! coachMessageCell
        let info = self.users[indexPath.row]
        cell.chatName.text = info.name?.capitalized
        
        if info.image != "" {
            cell.chatImage.kf.setImage(with: URL(string: info.image ?? ""   ))
        }else{
            cell.chatImage.image = UIImage(named: "empty_image")
        }
        if info.lastMessage != ""{
            if info.timestamp != nil {
                cell.timeLbl.isHidden = false
                
                if info.timestamp?.count != 10 {
                    let timeStamp = Date(timeIntervalSince1970: TimeInterval(info.timestamp!)! / 1000)
                    
                    cell.timeLbl.text = timeStamp.convertTimeInterval()
                    
                }else{
                    let timeStamp = Date(timeIntervalSince1970: TimeInterval(info.timestamp!)!)
                    
                    cell.timeLbl.text = timeStamp.convertTimeInterval()
                    
                }
                
            }else{
                cell.timeLbl.isHidden = true
            }
        }else{
        cell.timeLbl.isHidden = true
    }
        
        
        cell.chatName.text = info.name
        cell.chatMessage.text = info.lastMessage
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        guard let uidd = info.uid else {return}
        let vc  = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        let info = self.users[indexPath.row]
        vc.userName1 = info.name ?? ""
        vc.userImage1 = info.image ?? ""
        vc.userType = "chat"
        vc.userID = info.uid ?? ""
        vc.comingFrom = "coachMessageVC"
        //        vc.toId = info.uid ?? ""
        //        vc.toIDcomingFrom = info.uid ?? ""
        //        vc.userName = info.name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func sortUsersListByTime(usersArray: [FirebaseUser]) -> [FirebaseUser]{
        
        var arrayWithTimeStamp = [FirebaseUser]()
        var arrayWithoutTimeStap = [FirebaseUser]()
        
        usersArray.forEach { (user) in
            if user.timestamp == nil{
                arrayWithoutTimeStap.append(user)
            }else{
                arrayWithTimeStamp.append(user)
            }
        }
        
        arrayWithTimeStamp = arrayWithTimeStamp.sorted(by: { $0.timestamp! > $1.timestamp! })
        let newArray = arrayWithTimeStamp + arrayWithoutTimeStap
        return newArray
        
    }
}
