//
//  NotificationVC.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//


import UIKit
import MBProgressHUD
class NotificationVC: UIViewController , UITableViewDelegate , UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentOutlet: UISegmentedControl!
    
    var clientListDict = [String:Any]()
    var clientPending = [clientPendingData]()
    var clientAccept = [clientAcceptData]()

    var clientReject = [clientRejectData]()
    var clientRejectDict = [String:Any]()
    
    var clientPendingDict = [String:Any]()
    var indexValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
//        clientAcceptApi()
        segmentOutlet.layer.cornerRadius = 10
        segmentOutlet.layer.masksToBounds = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
     clientAcceptApi()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if indexValue == 0 {
            return clientAccept.count
            
        }else if indexValue == 1 {
           
            return clientReject.count
            
        } else if indexValue == 2 {
            
            return clientPending.count
        }
        return 0
//        var value = 0
//        switch segmentOutlet.selectedSegmentIndex{
//        case 0 :
//
//            return clientAccept.count
//        case 1:
//
//            return clientReject.count
//        case 2:
//
//            return clientPending.count
//        default:
//            break
//        }
//        return value
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell") as! NotificationCell
        
        if indexValue == 0 {
            let acceptInfo = self.clientAccept[indexPath.row]
            if acceptInfo.profilePic != "" {
                
                DispatchQueue.global().async {
                    if let imageURL = URL(string: acceptInfo.profilePic) {
                        if let imageData = try? Data(contentsOf: imageURL) {
                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                            cell.profileImg.image = image
                            }
                        }
                    }
                }

                
                
                
//                cell.profileImg.kf.setImage(with: URL(string:acceptInfo.profilePic))
                cell.setNeedsLayout()
            }
            print(acceptInfo)
            cell.nameLbl.text = acceptInfo.coachName
            cell.messageLbl.text = acceptInfo.requestStatus
            cell.cellView.backgroundColor = UIColor(red: 237/255, green: 247/255, blue: 237/255, alpha: 1)
            
            return cell

        }else if indexValue == 1 {
            let RejectInfo = self.clientReject[indexPath.row]
            if RejectInfo.profilePic != "" {
            DispatchQueue.global().async {
            if let imageURL = URL(string: RejectInfo.profilePic) {
                if let imageData = try? Data(contentsOf: imageURL) {
                let image = UIImage(data: imageData)
                    DispatchQueue.main.async {
                    cell.profileImg.image = image
                            }
                        }
                    }
                }
                
//                cell.profileImg.kf.setImage(with: URL(string:RejectInfo.profilePic))
                cell.setNeedsLayout()
            }
            cell.nameLbl.text = RejectInfo.coachName
            cell.messageLbl.text = RejectInfo.requestStatus
            cell.cellView.backgroundColor = UIColor(red: 245/255, green: 218/255, blue: 218/255, alpha: 1)
            return cell
            
        } else if indexValue == 2 {
            let pendingInfo = self.clientPending[indexPath.row]
            if pendingInfo.profilePic != "" {
                DispatchQueue.global().async {
                    if let imageURL = URL(string: pendingInfo.profilePic) {
                        if let imageData = try? Data(contentsOf: imageURL) {
                            let image = UIImage(data: imageData)
                            DispatchQueue.main.async {
                                cell.profileImg.image = image
                            }
                        }
                    }
                }
                
//                cell.profileImg.kf.setImage(with: URL(string:pendingInfo.profilePic))
                cell.setNeedsLayout()
            }
            
            cell.cellView.backgroundColor = UIColor(red: 255/255, green: 237/255, blue: 221/255, alpha: 1  )
            cell.nameLbl.text =    pendingInfo.coachName
            cell.messageLbl.text = pendingInfo.requestStatus
            
            return cell
            
        }
         return UITableViewCell()
            
//        switch segmentOutlet.selectedSegmentIndex{
//        case 0:
//            let acceptInfo = self.clientAccept[indexPath.row]
//            if acceptInfo.profilePic != "" {
//                cell.profileImg.kf.setImage(with: URL(string:acceptInfo.profilePic))
//                cell.setNeedsLayout()
//            }
//            print(acceptInfo)
//            cell.nameLbl.text = acceptInfo.coachName
//            cell.messageLbl.text = acceptInfo.requestStatus
//            cell.cellView.backgroundColor = UIColor(red: 225/255, green: 248/255, blue: 236/255, alpha: 1)
//            break
//        case 1 :
//            let RejectInfo = self.clientReject[indexPath.row]
//            if RejectInfo.profilePic != "" {
//                cell.profileImg.kf.setImage(with: URL(string:RejectInfo.profilePic))
//                cell.setNeedsLayout()
//            }
//            cell.nameLbl.text = RejectInfo.coachName
//            cell.messageLbl.text = RejectInfo.requestStatus
//            cell.cellView.backgroundColor = UIColor(red: 250/255, green: 217/255, blue: 217/255, alpha: 1)
//            print(RejectInfo)
//            break
//        case 2 :
//            let pendingInfo = self.clientPending[indexPath.row]
//            if pendingInfo.profilePic != "" {
//                cell.profileImg.kf.setImage(with: URL(string:pendingInfo.profilePic))
//                cell.setNeedsLayout()
//            }
//
//            cell.cellView.backgroundColor = UIColor(red: 255/255, green: 237/255, blue: 219/255, alpha: 1  )
//            cell.nameLbl.text = pendingInfo.coachName
//            cell.messageLbl.text = pendingInfo.requestStatus
//            print(pendingInfo)
//        default:
//            break
//        }
      //  return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    @IBAction func onClickSegment(_ sender: Any) {
        
        var value = 0
        switch segmentOutlet.selectedSegmentIndex{
        case 0 :
            indexValue = 0
            self.clientPending.removeAll()
            self.clientReject.removeAll()
            
            segmentOutlet.selectedSegmentTintColor = .systemGreen
            clientAcceptApi()
            
        case 1:
            indexValue = 1
            
            self.clientPending.removeAll()
            self.clientAccept.removeAll()
            segmentOutlet.selectedSegmentTintColor = .systemRed
            clientRejectApi()
        case 2:
            indexValue = 2
            self.clientReject.removeAll()
            self.clientAccept.removeAll()
            
            segmentOutlet.selectedSegmentTintColor = .systemYellow
            clientPendingApi()
        default:
            break
        }
//        DispatchQueue.main.async {
//       self.tableView.reloadData()
//        }
       
    }
    
    @IBAction func onClickBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    //  ClientacceptNotificationApi
    
    func clientAcceptApi()
    {
        let userId =    UserDefaults.standard.getUserID()
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/client_approved_status.php"
        let parameters = ["user_id": userId]
        var urlRequest = URLRequest(url: URL(string: urlStr)!)
        urlRequest.httpMethod = "POST"
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        showLoading()

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error == nil && data != nil && data?.count != 0{
                print(String(data: data!, encoding: .utf8)!)
                let jsonDecoder = JSONDecoder()
                let response = response as! HTTPURLResponse
                print(response.statusCode)
                let statusCode = response.statusCode
                do {
                    let result = try jsonDecoder.decode(ClientAcceptResponse.self, from: data!)
                    print(result)
                    self.clientReject.removeAll()
                    self.clientPending.removeAll()
                    
                    if result.success == "true"
                    {
                        hideLoading()

                        self.clientAccept = result.data ?? []
                        print(self.clientListDict.count)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    }
                    else
                    {
                        hideLoading()
                        DispatchQueue.main.async {
                            self.makeToast("Nothing to found any requests accepted by coach")
                            self.tableView.reloadData()

                        }
                    }
                 
                    //completion(.success(result))
                } catch let error {
                    hideLoading()
                    //completion(.failure(error))
                }
            }else{
                hideLoading()
                let error = error as NSError?
                self.makeToast("Nothing to found any requests accepted by coach")
            }
        }.resume()
    }
    
    //   ClientRejectNotificationApi
        func clientRejectApi()
        {
        let userId =    UserDefaults.standard.getUserID()
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/client_rejected_status.php"
        let parameters = ["user_id": userId]
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
                    let result = try jsonDecoder.decode(ClientRejectResponse.self, from: data!)
                    print(result)
                    self.clientAccept.removeAll()
                    self.clientPending.removeAll()
                    
                    if result.success == "true"
                    {
                        
                  
                        self.clientReject = result.data ?? []
                        print(self.clientRejectDict.count)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }

                      
                    }
                    else{
                        DispatchQueue.main.async {
                            self.makeToast("Nothing to found any request is Rejected by coach.")
                            self.tableView.reloadData()

                        }
                        
                    }

                    //completion(.success(result))
                } catch let error {
                    //completion(.failure(error))
                }
            }else{
                let error = error as NSError?
            }
            
        }.resume()
    }
    
    
    //     ClientPendingNotificationApi
    
    
    func clientPendingApi()
    {
        let userId =    UserDefaults.standard.getUserID()
        let urlStr = "https://chawtechsolutions.co.in/dev/apex/api/client_pending_status.php"
        let parameters = ["user_id": userId]
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
                    let result = try jsonDecoder.decode(clientPendingResponse.self, from: data!)
                    print(result)
                    
                    self.clientReject.removeAll()
                    self.clientAccept.removeAll()
                    
                    if result.success == "true"
                    {

                        self.clientPending = result.data ?? []
                        print(self.clientPendingDict.count)
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }

                        
                    }
                    else{
                        DispatchQueue.main.async {
                    self.makeToast("Nothing to found any request is Pending by coach.")
                            self.tableView.reloadData()

                        }
                    }

                    
                    //completion(.success(result))
                } catch let error {
                    //completion(.failure(error))
                }
            }else{
                let error = error as NSError?
            }
            
        }.resume()
    }
    
    
    
}
