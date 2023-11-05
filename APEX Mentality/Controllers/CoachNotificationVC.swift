//
//  CoachNotificationVC.swift
//  APEX Mentality
//
//  Created by CTS on 31/07/23.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import MBProgressHUD

class CoachNotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    let chatViewModel = ChatViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    var couchid = ""
    var lastMessage = ""
    var isloading = false
    
    var coachNotificationList = [coachNotificationData]()
    var coachAcceptList = [CoachAcceptData]()
    var coachRejectList = [CoachRejectData]()
    
    var coachNotificationListDict = [String:Any]()
    var coachAcceptListDict = [String:Any]()
    var coachRejectListDict = [String:Any]()
    
    var colorArray = [UIColor.green , UIColor.red]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isloading == false {
            coachNotificationListApi()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coachNotificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoachNotificationCell") as! CoachNotificationCell
        cell.selectionStyle = .none
        let info = self.coachNotificationList[indexPath.row]
        if info.profileImage != "" {
            cell.notificationImage.kf.setImage(with: URL(string:info.profileImage ?? ""))
        }
        
        
        print(info.clientStatus)
        if info.clientStatus == "Approved" {
            cell.statusLbl.text = "Approved"
            cell.statusLbl.isHidden = false
            cell.aceeptBtn.isHidden = true
            cell.rejectBtn.isHidden = true
            
        }else if info.clientStatus == "Rejected" {
            cell.statusLbl.text = "Rejected"
            cell.statusLbl.isHidden = false
            // cell.rejectBtn.setTitle("Rejected", for: .normal)
            cell.aceeptBtn.isHidden = true
            cell.rejectBtn.isHidden = true
        }
        
        else if info.clientStatus == "Pending"{
            cell.statusLbl.isHidden = true
           
            cell.aceeptBtn.isHidden = false
            cell.rejectBtn.isHidden = false
        }
        for color in colorArray {
            cell.rejectBtn.backgroundColor = color
        }
        
        
        cell.aceeptBtn.backgroundColor = UIColor(red: 0/255, green: 76/255, blue: 0/255, alpha: 1)
        cell.rejectBtn.backgroundColor = UIColor(red: 255/255, green: 44/255, blue: 4/255, alpha: 1)
        cell.nameLbl.text = info.clientName
        cell.aceeptBtn.tag = indexPath.row
        
        //     if String(cell.aceeptBtn.tag) == "Approved"{
        cell.aceeptBtn.addTarget(self, action: #selector(approveStatusBtnClicked(sender:)), for: .touchUpInside)
        cell.rejectBtn.tag = indexPath.row
        cell.rejectBtn.addTarget(self, action: #selector(rejectStatusBtnClicked(sender:)), for: .touchUpInside)

        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        UIApplication.shared.windows.first?.rootViewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    // Hide the loader
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    //  coachNotificationApi
    func coachNotificationListApi()
    {
        DispatchQueue.main.async {
        self.showLoader()
        }
        let userId =    UserDefaults.standard.getUserID()
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/coachnotifications.php"
        let parameters = ["couchid": userId ]
        var urlRequest = URLRequest(url: URL(string: urlStr)!)
        urlRequest.httpMethod = "POST"
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            
            print(error.localizedDescription)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                do {
                    let result = try jsonDecoder.decode(CoachNotificationResponse.self, from: data!)
                    print(result)
                    if result.status == "success"
                    {
                        self.isloading = true
                        
                        self.coachNotificationList = result.data
                        DispatchQueue.main.async {
                            self.hideLoader()
                            self.tableView.reloadData()
                            
                        }
                    }else{
                        self.isloading = true
                        DispatchQueue.main.async {
                            self.hideLoader()
                    self.makeToast(result.message ?? "")
            }
                        
                    }
                    //completion(.success(result))
                } catch let error {
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.makeToast("Coach is not assign")
                    }
                    
                    print("Error")
                }
            }else{
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.makeToast("Coach is not assign")
                }
                
            let error = error as NSError?
            }
        }.resume()
    }
    
    
    
    // coachAcceptApi
    @objc func approveStatusBtnClicked(sender:UIButton)
    {
        let info = self.coachNotificationList[sender.tag]
        guard let couchId = UserDefaults.standard.getUserID() else {return}
        guard let userId = info.clientID else { return  }
        let userName = info.clientName
        let statusStr = "Approved"
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/statusaccepted.php"
        let toProfileImage = info.profileImage ?? ""
        statusApiCall(statusStr: statusStr, couchId: couchId, userId: userId, urlStr: urlStr , userName: userName ?? "" ,toProfileImage: toProfileImage)
      //  self.getAssignedCoachConversationId(toIdStr: userId, userNameStr: userName ?? "")
        //        self.tableView.reloadData()
        
    }
    @objc func rejectStatusBtnClicked(sender:UIButton)
    {
        let info = self.coachNotificationList[sender.tag]
        guard let couchId = UserDefaults.standard.getUserID() else {return}
        guard let userId = info.clientID else { return  }
        guard let userName = info.clientName else { return }
        let statusStr = "Rejected"
        
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/statusrejected.php"
        
        statusApiCall(statusStr: statusStr, couchId: couchId, userId: userId, urlStr: urlStr , userName: userName, toProfileImage: "")
        //          self.tableView.reloadData()
    }
    
    func statusApiCall(statusStr: String, couchId: String , userId: String, urlStr: String , userName:String,toProfileImage: String){
        //        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/statusaccepted.php"
        let parameters = ["coach_id": couchId , "user_id": userId , "status": statusStr]
        
        var urlRequest = URLRequest(url: URL(string: urlStr)!)
        urlRequest.httpMethod = "POST"
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                do {
                    let result = try jsonDecoder.decode(CoachAcceptResponse.self, from: data!)
                    print(result)
                    if result.status == "success"
                    {
                        //                       timer
                        //self.coachNotificationListApi()
                        if statusStr.lowercased() == "approved"
                        {
                            DispatchQueue.main.async {
                                self.coachNotificationListApi()
                            }
                            self.getAssignedCoachConversationId(toIdStr: userId, userNameStr: userName, toProfileImage: toProfileImage)
                        }
                        else{
                            DispatchQueue.main.async {
                                self.makeToast("Client Request has been Rejected!")
                                self.coachNotificationListApi()
                            }
                        }
                        
                    }
                    //completion(.success(result))
                } catch let error {
                    DispatchQueue.main.async {
                        
                        self.makeToast("No Coach Found")
                        self.tableView.reloadData()
                    }
                    
                }
            }else{
                let error = error as NSError?
                DispatchQueue.main.async {
                    
                    self.makeToast("No Coach Found")
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
    
    func getAssignedCoachConversationId(toIdStr:String,userNameStr:String,toProfileImage:String){

        let userName = UserDefaults.standard.getUserName()

        var userDic: [String:AnyObject] = [:]
        var userDic2: [String:AnyObject] = [:]

        userDic = [
            "name" : userName,
        ] as [String : AnyObject]
        
        var metadataDic: [String:AnyObject] = [:]
        metadataDic = [
            "user" : userDic
        ] as [String : AnyObject]
        
        userDic2 = [
            "name" : userNameStr,
        ] as [String : AnyObject]
        
        var metadataDic2: [String:AnyObject] = [:]
        metadataDic2 = [
            "user" : userDic2
        ] as [String : AnyObject]
        
        let timestamp = Int(Date().timeIntervalSince1970*1000)
        let fromId = UserDefaults.standard.getUserID()
        let userImage = UserDefaults.standard.getProfileImg()
        debugPrint(userImage)
        let request = Message(fromID: fromId, toID: toIdStr)
        
        let location = NSUUID().uuidString.lowercased()
        let userDict = [
            "image": userImage ?? "",
            "lastMessage" : "",
            "location"   : location ,
            "time"  : "\(timestamp)",
            "timestamp": "\(timestamp)",
            "metaData":metadataDic] as [String : Any]
        
        let userDict2 = [
            "image": toProfileImage,
            "lastMessage" : "",
            "location"   : location ,
            "time"  : "\(timestamp)",
            "timestamp":"\(timestamp)",
            "metaData":metadataDic2] as [String : Any]
        
        let newUserDict = [
            "email": "",
            "fcmKey": "",
            "userName": userName ?? "" ] as [String : Any]
        
         let newCoachDict = [
            "email": "",
            "fcmKey": "",
            "userName": userNameStr] as [String : Any]
       
        print(userDict)
        print(newUserDict)
        
        Database.database().reference().child("asignCoach").child("\(toIdStr)").updateChildValues(newCoachDict as [AnyHashable : Any])
        
        Database.database().reference().child("asignCoach").child("\(String(describing: toIdStr))").child("conversations").child("\(fromId!)").updateChildValues(userDict as [AnyHashable : Any])
        
        // Database.database().reference().child("asignCoach").child("\(String(describing: fromId!))").child("conversations").child("\(toIdStr)").updateChildValues(userDict as [AnyHashable : Any])
        
        Database.database().reference().child("users").child("\(toIdStr)").child("conversations").child("\(String(describing: fromId!))").updateChildValues(userDict as [AnyHashable : Any])

        
        Database.database().reference().child("users").child("\(String(describing: fromId!))").child("conversations").child("\(toIdStr)").updateChildValues(userDict2 as [AnyHashable : Any])
        
//        chatViewModel.getConversationId(request: request) { (conversationId) in
//
//            Database.database().reference().child("asignCoach").child("\(toIdStr)").updateChildValues(newCoachDict as [AnyHashable : Any])
//
//            Database.database().reference().child("asignCoach").child("\(String(describing: toIdStr))").child("conversations").child("\(fromId!)").updateChildValues(userDict as [AnyHashable : Any])
//
//            // Database.database().reference().child("asignCoach").child("\(String(describing: fromId!))").child("conversations").child("\(toIdStr)").updateChildValues(userDict as [AnyHashable : Any])
//
//            Database.database().reference().child("users").child("\(toIdStr)").child("conversations").child("\(String(describing: fromId!))").updateChildValues(userDict as [AnyHashable : Any])
//
//
//            Database.database().reference().child("users").child("\(String(describing: fromId!))").child("conversations").child("\(toIdStr)").updateChildValues(userDict2 as [AnyHashable : Any])
//
//
//        } onError: { (errorMesage) in
//            DispatchQueue.main.async {
//                //              showMessageAlert(message: errorMesage)k
//            }
//        }
    }
    
    
}


extension UITableView {
    func reloadDataAfterDelay(delayTime: TimeInterval = 0.5) -> Void {
        self.perform(#selector(self.reloadData), with: nil, afterDelay: delayTime)
    }
    
}
