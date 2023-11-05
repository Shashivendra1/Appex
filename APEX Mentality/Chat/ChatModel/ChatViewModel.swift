//
//  ChatViewModel.swift
//  APEX Mentality
//
//  Created by CTS on 09/08/23.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct ChatViewModel {
    
    private let fdbRef = Database.database().reference()
    func getUsersList(onSuccess:@escaping([FirebaseUser]) -> Void, onError:@escaping(String) -> Void){

        var users = [FirebaseUser]()
        var clientType = ""
        print(users)
        guard let userId = UserDefaults.standard.getUserID() else { return  }
        
        let userType = UserDefaults.standard.getUserRole()
        
        if userType?.lowercased() == "client"{
            clientType = "asignCoach"
        }else{
            clientType = "users"
        }
        //fdbRef.child("users").child(userId).observeSingleEvent(of:.value) { snapshot,data in
        fdbRef.child(clientType).child(userId).observeSingleEvent(of:.value) { snapshot,data in

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
                        print(userDict)
                        for (key, value) in userDict {
                            print("key is - \(key) and value is - \(value)")
                            let metaData = value["metaData"] as? NSMutableDictionary
                            let user = metaData?["user"] as? NSMutableDictionary
                            let vendor = metaData?["name"] as? NSMutableDictionary
                            if key != "adminapex444"{
                                //                                let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as? String, name: user?["name"] as? String, image: value["image"] as? String, fcmKey: fcm_key, timestamp: value["timestamp"] as? String, time: value["time"] as? String)
                                let userInstance = FirebaseUser(uid: key, email: email, lastMessage: value["lastMessage"] as? String, name: user?["name"] as? String, image: value["image"] as? String, fcmKey: fcm_key, timestamp: value["timestamp"] as? String, time: value["time"] as? String)
                                users.append(userInstance)
                            }
                        } // End for loop
print(users)
                    }
                }
                let sortedUserArray = sortUsersListByTime(usersArray: users)
                onSuccess(sortedUserArray)
            }else{
                onSuccess(users)
            }
        }
    }
    
        private func sortUsersListByTime(usersArray: [FirebaseUser]) -> [FirebaseUser]{
        
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
    
    func getConversationId(request: Message, onSuccess:@escaping(String?) -> Void, onError:@escaping(String) -> Void){
        
        var clientType = ""
        let userType = UserDefaults.standard.getUserRole()
        if request.toID != "adminapex444"{
            clientType = "asignCoach"
        }else{
            clientType = "users"
        }
        fdbRef.child("users").child(request.fromID ?? "" ).child("conversations").child(request.toID!).observe( .value) { (snapshot) in
            print(snapshot)
      //  fdbRef.child("users").child(request.fromID ?? "" ).child("conversations").child(request.toID!).observe( .value) { (snapshot) in
            
            if snapshot.exists(){
                if let dataDict = snapshot.value as? [String:AnyObject]{
                    let conversationId = dataDict["location"]
                    onSuccess(conversationId as? String)
                }
            }else{
                onSuccess(nil)
            }
        }
    }
    
    
    func getMessages(conversationId: String? = "abc", onSuccess:@escaping([Message]) -> Void){
        var messages = [Message]()
        
        fdbRef.child("conversations").child(conversationId ?? "abc").observe(.childAdded) { (snapshot) in
            print(snapshot)
//            NotificationCenter.default.post(name: NSNotification.Name("Message"), object: nil)
          //  NotificationCenter.default.post(name: NSNotification.Name(NotificationKeys.MESSAGE), object: nil)
            guard snapshot.exists() else { return }
            if let dataDict = snapshot.value as? [String:AnyObject]{
                let content = dataDict["content"] as? String
                let fromId = dataDict["fromID"] as? String
                let toId = dataDict["toID"] as? String
                let isRead = dataDict["isRead"] as? Bool
               // let timestamp = dataDict["timestamp"] //Int(Date().timeIntervalSince1970*1000)
               // print(timestamp)
                var timestamp = ""
                if let timestamp2 = dataDict["timestamp"] as? String {
                    timestamp = timestamp2
                } else {
                    
                    // Handle the case where 'timestamp' is not a String
                    print("'timestamp' is not a String")
                    if let timestamp5 = dataDict["timestamp"] as? Int64 {
                        timestamp = String(timestamp5)
//                        let date = Date(timeIntervalSince1970: TimeInterval(timestamp5)*1000)
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // Customize the format
//                        let dateString = dateFormatter.string(from: date)
//                        print("Formatted Timestamp: \(dateString)")
//                        timestamp = "\(dateString)"
                    }
                }
                let queryID = dataDict["queryId"] as? String
                let type = dataDict["type"] as? String
                let name = dataDict["name"] as? String
                
               // print("*******************************\(timestamp)")
                
                let message = Message(content: content, fromID: fromId, timestamp: "\(timestamp)", isRead: isRead, toID: toId, type: type,queryId : queryID , name: name)
                messages.append(message)
                onSuccess(messages)
            }
        }
    }
    
    func sendMessage(request: Message, onSuccess:@escaping(String) -> Void){

        let messageDict = request.convertToDictionary()!
        var metadataDic: [String:AnyObject] = [:]
        var metadataDic1: [String:AnyObject] = [:]
        var userDic: [String:AnyObject] = [:]
        var userDic1: [String:AnyObject] = [:]
        var vendorDic: [String:AnyObject] = [:]
       guard let userName = UserDefaults.standard.getUserName()else{return}
        let user = UserDefaults.standard.string( forKey: userName)
        
        userDic = [
            "name" : request.name ?? "",
        ] as [String : AnyObject]
        print(metadataDic)
        
        metadataDic = [
            "user" : userDic
        ] as [String : AnyObject]
        
        userDic1 = [
            "name" : userName,
        ] as [String : AnyObject]
        
        metadataDic1 = [
            "user" : userDic1
        ] as [String : AnyObject]

        
        
        fdbRef.child("users").child(request.fromID!).child("conversations").child(request.toID!).observeSingleEvent(of: .value) { (snapshot) in
            var conversationId = ""
            var conversationDict: [String:Any] = [:]
            let userType = UserDefaults.standard.getUserRole()
            if let dataDict = snapshot.value as? [String : AnyObject]{
                let profileImgUrl = UserDefaults.standard.getProfile()
                
                conversationId = dataDict["location"] as! String
                conversationDict = [
                    "timestamp" : request.timestamp!,
                    "lastMessage" : request.content!,
                    "image" : request.image!,
                    "time"  : request.timestamp!,
                   // "name" : userName,
//                    "name" : request.name,
                    "metaData" : metadataDic
                ] as [String : Any]
                
                print(dataDict)
            }
            
            else{
                conversationId = NSUUID().uuidString.lowercased()
                let profileImgUrl = UserDefaults.standard.getProfile()
                    conversationDict = [
                    "location" : conversationId,
                    "image" : request.image! ,
                    "time"  : request.timestamp!,
                    //"name" : request.name,
                    "lastMessage" : request.content!,
                    "timestamp" : request.timestamp!,
                    "metaData" : metadataDic
                ] as [String : Any]
            }
            
            
            
            var conversationDict1: [String:Any] = [:]
            if let dataDict = snapshot.value as? [String : AnyObject]{
                let profileImgUrl = UserDefaults.standard.getProfile()
                
                conversationId = dataDict["location"] as! String
                conversationDict1 = [
                    "timestamp" : request.timestamp!,
                    "lastMessage" : request.content!,
                    "image" : profileImgUrl,
                    "time"  : request.timestamp!,
                   // "name" : userName,
//                    "name" : request.name,
                    "metaData" : metadataDic1
                ] as [String : Any]
                
                print(dataDict)
            }
            
            else{
                conversationId = NSUUID().uuidString.lowercased()
                let profileImgUrl = UserDefaults.standard.getProfile()
                    conversationDict = [
                    "location" : conversationId,
                    "image" : profileImgUrl ,
                    "time"  : request.timestamp!,
                    //"name" : request.name,
                    "lastMessage" : request.content!,
                    "timestamp" : request.timestamp!,
                    "metaData" : metadataDic1
                ] as [String : Any]
            }
        print(conversationDict)
      
         

            
            self.fdbRef.child("conversations").child(conversationId).childByAutoId().updateChildValues(messageDict as [String:AnyObject])
            
            if userType == "coache" {
                
                if request.toID == "adminapex444"{
                    
                    self.fdbRef.child("users").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict)
                    
                    self.fdbRef.child("users").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict)
                }else{
                    
                    self.fdbRef.child("users").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict)
                    
                    self.fdbRef.child("users").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict)
                    
                    self.fdbRef.child("asignCoach").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict1)
                }
                
            }else if userType == "client"{
                
                if request.toID == "adminapex444"{
                    
                    self.fdbRef.child("users").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict)
                    
                     self.fdbRef.child("users").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict)
                }else {
                    
                    self.fdbRef.child("users").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict1)
                    
                    self.fdbRef.child("users").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict1)
                    
                    
                    self.fdbRef.child("asignCoach").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict)
                }
            }
//            if request.toID != "adminapex444"{
//                
//              //  self.fdbRef.child("asignCoach").child(request.toID!).child("conversations").child(request.fromID!).updateChildValues(conversationDict)
//                
//                self.fdbRef.child("asignCoach").child(request.fromID!).child("conversations").child(request.toID!).updateChildValues(conversationDict)
//            }

            
            onSuccess(conversationId)
        }
    }
}


extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }

        return arrayOrdered
    }
}
