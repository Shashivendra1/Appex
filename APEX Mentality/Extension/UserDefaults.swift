//
//  UserDefaults.swift
//  APEX Mentality
//
//  Created by CTS on 20/07/23.
//

import Foundation
extension UserDefaults{
    
    func saveFcmToken(fcmKey : String){
               UserDefaults.standard.set(fcmKey , forKey: "fcm_key")
               }
   
   func getFcmToken() -> String?{
        return UserDefaults.standard.value(forKey: "fcm_key") as? String
           }
        
        func setUserLoggedIn(_ bool: Bool){
        UserDefaults.standard.set(bool, forKey: "LOGGED_IN")
    }

    func saveUserID(userID: String){
        UserDefaults.standard.set(userID, forKey: "user_id")
    }
    
    func getUserID() -> String?{
        return UserDefaults.standard.value(forKey: "user_id") as? String
    }
      
    func saveUserName(userName: String){
        UserDefaults.standard.set(userName , forKey: "user_name")
    }
    
        func getUserName() -> String?{
        return UserDefaults.standard.value(forKey: "user_name") as? String
    }
    
    func saveUserRole(userRole: String){
        UserDefaults.standard.set(userRole , forKey: "userRole")
    }
    
        func getUserRole() -> String?{
        return UserDefaults.standard.value(forKey: "userRole") as? String
    }
    
        func saveEmail(email: String){
        UserDefaults.standard.set(email, forKey: "EMAIL")
    }
    
    func getEmail() -> String?{
        return UserDefaults.standard.value(forKey: "EMAIL") as? String
    }
    
    
    func savePhoneNo(phoneNo: String){
    UserDefaults.standard.set(phoneNo, forKey: "phone")
}

func getPhoneNo() -> String?{
    return UserDefaults.standard.value(forKey: "phone") as? String
}
      
    
func saveProfileImg(ProfileImage: String){
    UserDefaults.standard.set(ProfileImage, forKey: "userImage")
}

func getProfileImg() -> String?{
    return UserDefaults.standard.value(forKey: "userImage") as? String
}
    
    
    func saveProfilePic(profile : String){
        UserDefaults.standard.set(profile , forKey: "profilePC")
        }

    func getProfile() -> String?{
        return UserDefaults.standard.value(forKey: "profilePC") as? String
    }
    
    
    func saveCouchId(coach_id : String){
        UserDefaults.standard.set(coach_id, forKey: "coach_id")
    }
    
    func getCouchId()  -> String?{
    return UserDefaults.standard.value(forKey: "coach_id") as! String
        
    }

    func isUserLoggedIn() -> Bool{
        if let isUserLoggedIn: Bool = UserDefaults.standard.value(forKey: "LOGGED_IN") as? Bool{
            return isUserLoggedIn
        }else{
            return false
        }
        
    }
}
