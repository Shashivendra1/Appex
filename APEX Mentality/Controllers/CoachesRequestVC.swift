//
//  CoachesRequestVC.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//

import UIKit
import Kingfisher
import Toast_Swift
class CoachesRequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var choachesLbl: UILabel!
    @IBOutlet weak var chatLbl: UILabel!
    
    @IBOutlet weak var coachesListView: UIView!
    @IBOutlet weak var chatListView: UIView!
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var selectedIndex = 0
    var coachList = [coachListData]()
    var chatUsersList = [FirebaseUser]()
    let chatViewModel = ChatViewModel()
    var couchid = ""
    var comingFrom = ""
    
    
    //    var sendList  = [sendListData]
    var sendRequestList = [sendRequestDataClass]()
    var sendRequestMsg = ""
    var coachListDict = [String:Any]()
    var sendRequestListDict = [String:Any]()
    let dispatchGroup = DispatchGroup()
    var coachesActive:Bool = false
    var chatActive:Bool = false
    
    var currentDate = ""
    var validDate = ""
    var planId = ""
    var planName = ""
    var totalAmount = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        coachesActive = true
        chatActive = false
        self.tabBarController?.tabBar.isHidden = false
        
        self.navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(SubscriptionPurchased), name: NSNotification.Name(rawValue: "SubscriptionPurchased"), object: nil)
        
    }
    
    @objc func SubscriptionPurchased(_ sender: Notification) {
        
        let senderData = sender.userInfo
        if let data = senderData as? [String: String] {
            
            self.planId = data["planId"] ?? ""
            self.planName = data["planName"] ?? ""
            self.currentDate = data["currentDate"] ?? ""
            self.validDate = data["validDate"] ?? ""
            self.totalAmount = data["totalAmount"] ?? ""

        //    subscriptionApi()

           
  print("update Profile success")
            }

        }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        selectedIndex = selectedSegmentIndex
        self.tabBarController?.tabBar.isHidden = false
        if selectedSegmentIndex == 0 {
            
            coachesActive = true
            chatActive = false
            coachListApi()
            
        }else {
            coachesActive = false
            chatActive = true
            getUsersList()
            
        }
        
        
        
        segmentView.selectedSegmentIndex = selectedSegmentIndex
        
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        if segmentView.selectedSegmentIndex == 0
        //        {
        //        return coachList.count
        //        }
        //        else
        //        {
        //        return chatUsersList.count
        ////            return 2
        //        }
        
        
        if selectedIndex == 0 {
            return coachList.count
        }
        else {
            return chatUsersList.count
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoachesRequestCell") as! CoachesRequestCell
        
        if selectedIndex == 0 {
            let info = self.coachList[indexPath.row]
            if info.profilePic != "" {
                cell.cellImg.kf.setImage(with: URL(string:info.profilePic))
            }
            if info.request != "" {
                cell.sendRequestOutlet.setTitle(info.request, for: .normal)
            }else{
                cell.sendRequestOutlet.setTitle("Send Request", for: .normal)
            }
            
            cell.sendRequestOutlet.tag = indexPath.row
            cell.sendRequestOutlet.addTarget(self, action: #selector(sendRequestBtnClicked(sender:)), for: .touchUpInside)
            cell.requestNameLbl.text = info.name
            cell.messageLbl.text = info.designation
            cell.selectionStyle = .none
        }
        else {
            cell.sendRequestOutlet.isHidden = true
            
            
            let info = self.chatUsersList[indexPath.row]
            cell.requestNameLbl.text = info.name
            if info.image != ""
            {
                cell.cellImg.kf.setImage(with: URL(string:info.image ?? ""   ))
            }

            //let timeStamp = Date(timeIntervalSince1970:(TimeInterval(info.time!)!) / 1000)
           // cell.sendRequestLbl.text = timeStamp.convertTimeInterval()
            cell.messageLbl.text = info.lastMessage
        }
        /*
         switch segmentView.selectedSegmentIndex{
         case 0:
         let info = self.coachList[indexPath.row]
         print(info)
         if info.profilePic != "" {
         cell.cellImg.kf.setImage(with: URL(string:info.profilePic))
         }
         if info.request != "" {
         cell.sendRequestOutlet.setTitle(info.request, for: .normal)
         }else{
         cell.sendRequestOutlet.setTitle("Send Request", for: .normal)
         }
         
         cell.sendRequestOutlet.tag = indexPath.row
         cell.sendRequestOutlet.addTarget(self, action: #selector(sendRequestBtnClicked(sender:)), for: .touchUpInside)
         cell.requestNameLbl.text = info.name
         cell.messageLbl.text = info.designation
         break
         case 1:
         cell.sendRequestOutlet.isHidden = true
         //            let chatInfo = self.chatUsersList[indexPath.row]
         //            cell.messageLbl.text = chatInfo.lastMessage
         //            cell.sendRequestLbl.text = chatInfo.timestamp
         //            cell.requestNameLbl.text = chatInfo.name
         
         let info = self.chatUsersList[indexPath.row]
         cell.requestNameLbl.text = info.name
         if info.image != ""
         {
         cell.cellImg.kf.setImage(with: URL(string:info.image ?? ""   ))
         print(info.image)
         }
         
         let timeStamp = Date(timeIntervalSince1970:     (TimeInterval(info.timestamp!)!) / 1000)
         cell.sendRequestLbl.text = timeStamp.convertTimeInterval()
         cell.messageLbl.text = info.lastMessage
         
         default:
         break
         cell
         }
         */
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        
        if selectedIndex == 1 {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
            let info = self.chatUsersList[indexPath.row]
            vc.userName1 = info.name ?? ""
            vc.userType = "chat"
            vc.userID = info.uid ?? ""
            
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    

    
    @IBAction func onClickSegment(_ sender: Any) {
        selectedSegmentIndex = segmentView.selectedSegmentIndex
        switch segmentView.selectedSegmentIndex{
        case 0:
            self.selectedIndex = 0
            chatUsersList.removeAll()
            coachListApi()
          
            
        case 1:
            self.selectedIndex = 1
            coachList.removeAll()
            getUsersList()
        default:
            return
        }
        
        //self.tableView.reloadData()
    }
    
    @IBAction func notificationActionBtn(_ sender: UIButton) {
        let vc = NotificationVC.instantiate(fromAppStoryboard: .main)
        pushToVC(vc, animated: true)
    }
    
    @IBAction func onClickCoaches(_ sender: Any) {
        if coachesActive {
            coachesActive = true
            choachesLbl.textColor = UIColor.white
            choachesLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            
            chatLbl.textColor = UIColor.black
            chatLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            //  segmentView.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            
        }else {
            chatActive = true
            choachesLbl.textColor = UIColor.black
            choachesLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            chatLbl.textColor = UIColor.white
            chatLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            // segmentView.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
        }
    }
    @IBAction func onClickChat(_ sender: Any) {
        
        if chatActive {
            chatActive = true
            getUsersList()
            chatLbl.textColor = UIColor.white
            chatLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            
            choachesLbl.textColor = UIColor.black
            choachesLbl.backgroundColor = UIColor(red: 255/255, green: 2555/255, blue: 255/255, alpha: 1)
            
            // segmentView.tintColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
            
        }else {
            coachesActive = true
            choachesLbl.textColor = UIColor.black
            choachesLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            chatLbl.textColor = UIColor.white
            chatLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            // segmentView.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
    }
    
    
    // coachList Api
    func coachListApi()
    {
        let userId =    UserDefaults.standard.getUserID()
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/get_coache_list.php"
        let parameters = ["user_id": userId   ]
        
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
                    let result = try jsonDecoder.decode(coachListResponse.self, from: data!)
                    print(result)
                    self.coachList.removeAll()
                    if result.status == "success"
                    {
                        self.coachList = result.data
                        print(self.coachListDict.count)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }else{
                        
                        DispatchQueue.main.async {
                            self.coachList.removeAll()
                            self.makeToast("No Coach Found.")
                            self.tableView.reloadData()
                        }
                    }
                    //completion(.success(result))
                } catch let error {
                    
                    
                    DispatchQueue.main.async {
                        self.coachList.removeAll()
                        self.makeToast("No Coach Found.")
                        self.tableView.reloadData()
                    }
                }
            }else{
                self.makeToast("No Coach Found.")
                let error = error as NSError?
            }
            
        }.resume()
    }
    
    //  ChatUserListData
    
    func getUsersList(){
        
        chatViewModel.getUsersList { (usersList) in
            self.chatUsersList = usersList
            print(self.chatUsersList)
            DispatchQueue.main.async {
                if self.chatUsersList.count > 0 {
                    
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                } else {
                    self.tableView.dataSource = self
                    self.tableView.delegate = self
                    self.tableView.reloadData()
                }
                
            }
            
        } onError: { (errorMessage) in
            print(errorMessage)
        }
    }
    
    
    @objc func sendRequestBtnClicked(sender:UIButton)
    {
        let info = self.coachList[sender.tag]
        guard let couchId = UserDefaults.standard.getUserID() else {return}
        print(info.userID)
        let userid = info.userID
        let sendRequest = "Requested"
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/requestsend.php"
        sendRequestApi(sendRequest:sendRequest ,couchid: couchId, userid: userid, urlStr: urlStr)
        //            self.tableView.reloadData()
    }
    
    //     sendRequestApi
    func sendRequestApi(sendRequest: String , couchid: String , userid: Int, urlStr: String)
    {
        //     let userId =   UserDefaults.standard.getUserID()
        //        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/requestsend.php"
        let parameters = ["userid": couchid ,  "couchid": userid] as [String : Any]
        
        var urlRequest = URLRequest(url: URL(string: urlStr)!)
        urlRequest.httpMethod = "POST"
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { [self] (data, response, error) in
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                do {
                    
                    let result = try jsonDecoder.decode(sendRequestResponse.self, from: data!)
                    print(result)
                    if result.status == "success"
                    {
                        
                        coachListApi()
                        //print(self.sendRequestMsg)
                        //self.sendRequestList = result.data
                        //self.sendRequestMsg = result.message ?? ""
                        //            print(self.sendRequestMsg)
                        //                DispatchQueue.main.async {
                        //                        self.tableView.reloadData()
                        //
                        //                }
                    }
                    else{
                        DispatchQueue.main.async {
                            
                            self.makeToast("No Coach Found")
                            self.tableView.reloadData()
                        }
                        
                    }
                    //completion(.success(result))
                } catch let error {
                    
                    self.makeToast(error.localizedDescription )
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }else{
                let error = error as NSError?
                self.makeToast(error?.localizedDescription ?? "No Coach Found")
            }
            
        }.resume()
    }
    
    
    
    @objc  func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}


