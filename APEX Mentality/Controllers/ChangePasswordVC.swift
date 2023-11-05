//
//  ChangePasswordVC.swift
//  APEX Mentality
//
//  Created by CTS on 25/09/23.
//

import UIKit
import MBProgressHUD

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var profileName: UILabel!
    
    @IBOutlet weak var profileMailId: UILabel!
    
    @IBOutlet weak var oldPasswordTxt: UITextField!
    
    @IBOutlet weak var newPassswordTxt: UITextField!
    
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    
    @IBOutlet weak var ProfileImg: UIImageView!
   
    
    @IBOutlet weak var oldPasswordView: UIView!
    
    @IBOutlet weak var newPasswordView: UIView!
    
    @IBOutlet weak var confirmPasswordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.oldPasswordView.cornerRadius = 20
        self.newPasswordView.cornerRadius = 20
        self.confirmPasswordView.cornerRadius = 20
        ProfileImg.clipsToBounds = true
        ProfileImg.cornerRadius = 60
        ProfileImg.layer.borderColor = UIColor(red: 229/255, green: 193/255, blue: 3/255, alpha: 1).cgColor
        ProfileImg.layer.borderWidth = 5
        
        let userName = UserDefaults.standard.getUserName()
        let userMailId = UserDefaults.standard.getEmail()
        self.profileName.text = userName
        self.profileMailId.text = userMailId
        let profileImg = UserDefaults.standard.getProfile()
       
        if profileImg != nil {
            
            if profileImg == "" {
                self.ProfileImg.image = UIImage(named: "empty_image")
            }else{
                self.ProfileImg.kf.setImage(with: URL(string: profileImg!))
            }
        }
    self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickSubmitBtn(_ sender: Any) {
        print(UserDefaults.standard.getUserID())
        guard let userID = UserDefaults.standard.getUserID() else { return }
        let currentPassword = oldPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPassword = newPassswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirmPassword = confirmPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
 
        let changePasswordRequest = ChangePasswordRequest(userID: "\(userID)", oldPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
//        if newPassword == confirmPassword{
        let changePasswordValidation = ChangePasswordValidation()
    
        let validationResult = changePasswordValidation.validate(request: changePasswordRequest)
        if validationResult.success == true{
            sendRequestForChangePassword(request: changePasswordRequest)
        }
        else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
//            }
//            else{
//            self.makeToast("Password should be same")
//
//            }
        
    }
    
     func sendRequestForChangePassword(request: ChangePasswordRequest){
                DispatchQueue.main.async {
                self.showLoader()
            }
            
            let profileResource = ProfileResource()
            profileResource.changePassword(request: request) { (response) in
                    if response.success == "true"{
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.oldPasswordTxt.text = ""
                        self.newPassswordTxt.text = ""
                        self.confirmPasswordTxt.text = ""
                        self.makeToast(response.message)
                        self.makeToast("Password changed successfully")
                        self.navigationController?.popViewController(animated: true)
                    }
                }else{
                    DispatchQueue.main.async {
                        self.hideLoader()
                        self.makeToast(response.message)
                    }
            }
                
            } onError: { (error) in
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.makeToast(error.localizedDescription)
                }
            }

        }
    
    
    func showLoader() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    // Hide the loader
    func hideLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
}
