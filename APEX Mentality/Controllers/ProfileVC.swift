////
////  ProfileVC.swift
////  APEX Mentality
////
////  Created by CTS-Puja  on 26/06/23.
////
//

import UIKit
import ImageIO
import Kingfisher
import MBProgressHUD

class ProfileVC: UIViewController,  UIImagePickerControllerDelegate  {
    var userProfileData: ProfileData?
    var profilePicPath: String?
    var refresher = UIRefreshControl()

    @IBOutlet weak var cameraIcon: UIButton!

    @IBOutlet weak var myProfileView: UIView!

    @IBOutlet weak var profileImgView: UIView!

    @IBOutlet weak var profileImg: UIImageView!

    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var profileMialId: UILabel!
        
    @IBOutlet weak var changePasswordView: UIView!

    @IBOutlet weak var profileView: UIView!

    @IBOutlet weak var changePassView: UIView!

    @IBOutlet weak var fullNameView
    : UIView!

    @IBOutlet weak var logoutView: UIView!

    @IBOutlet weak var myProfileSubmitView: UIView!
    
    
    @IBOutlet weak var deleteAccountView: UIView!
    
    
    
    @IBOutlet weak var FullNameTxt: UITextField!
    
    
    
    @IBOutlet weak var changePasswordTxt: UITextField!
    
    
    
    @IBOutlet weak var logOutTxt: UITextField!
    
    
    @IBOutlet weak var DeleteAccountTxt: UITextField!
    
  
    @IBOutlet weak var stackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FullNameTxt.attributedPlaceholder = NSAttributedString(
                    string: "My Profile",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
        
        
        changePasswordTxt.attributedPlaceholder = NSAttributedString(
                    string: "Change Password",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
        logOutTxt.attributedPlaceholder = NSAttributedString(
                    string: "Log Out",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
        DeleteAccountTxt.attributedPlaceholder = NSAttributedString(
                    string: "Delete Account",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                )
      
        
//        self.tabBarController?.tabBar.isHidden = false
        let userName = UserDefaults.standard.getUserName()
        self.nameLbl.text = userName
//      self.profileName.text = userName
        
        let emailId = UserDefaults.standard.getEmail()
        self.profileMialId.text = emailId

        profileImg.clipsToBounds = true
        profileImg.cornerRadius = 60
        
        profileImg.layer.borderColor = UIColor(red: 229/255, green: 193/255, blue: 3/255, alpha: 1).cgColor
        profileImg.layer.borderWidth = 5
      
        nameLbl.text = ""
       // profileImg.image = nil
        getUserProfile()
        

//        profileImgView.layer.masksToBounds = true
//        profileImgView.layer.cornerRadius = profileImg.frame.height/2


//        self.showAlert(message: "Please Enter Valid Credentials", title: "Alert")
//        self.tabBarController?.delegate = self
        self.profileView.layer.cornerRadius = 20
        self.changePassView.layer.cornerRadius = 20
        //  self.fullNameView.layer.cornerRadius = 20
        self.logoutView.layer.cornerRadius = 20
        self.deleteAccountView.layer.cornerRadius = 20
//        self.myProfileSubmitView.layer.cornerRadius = 20
//        self.oldPasswordView.layer.cornerRadius = 20
//        self.emailIdView.layer.cornerRadius = 20
//        self.newPasswordView.layer.cornerRadius = 20
//        self.confirmPasswordView.layer.cornerRadius = 20
//        self.changePasswordSubmitView.layer.cornerRadius = 20
//        self.phoneView.layer.cornerRadius = 20

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        let userName = UserDefaults.standard.getUserName()
        self.nameLbl.text = userName
//       self.profileName.text = userName
        
        let emailId = UserDefaults.standard.getEmail()
        self.profileMialId.text = emailId
        
        let profileImg = UserDefaults.standard.getProfile()
        if profileImg != nil
        {
            self.profileImg.kf.setImage(with: URL(string: profileImg!), placeholder:UIImage(named:"empty_image"))
            
        }else {
            self.profileImg.kf.setImage(with: URL(string: profileImg!), placeholder:UIImage(named:"empty_image"))
            print("no image")
            
        }
    }
    
   
    
    
    @IBAction func onClickCameraIcon(_ sender: Any) {
    let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
//        imagePicker.delegate = self

        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            imagePicker.sourceType = .camera
            DispatchQueue.main.async {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }

        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            DispatchQueue.main.async {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }

        alert.addAction(cameraAction)
        alert.addAction(photoLibrary)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onClickProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
        
//        changePasswordView.isHidden = true
//        myProfileView.isHidden = false
//      self.onClickProfilePicture
    }

    @IBAction func onClickChangePassword(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
//        stackView.isHidden = true
//        changePasswordView.isHidden = false
//        myProfileView.isHidden = true
    }

    @IBAction func onClickMyProfileSubmitBtn(_ sender: Any) {
//        stackView.isHidden = false
//        changePasswordView.isHidden = true
//        myProfileView.isHidden = true
       
}

//    @IBAction func onClickChangePassSubmitBtn(_ sender: Any) {
////        stackView.isHidden = false
//        changePasswordView.isHidden = true
//        myProfileView.isHidden = true
//
//        print(UserDefaults.standard.getUserID())
//        guard let userID = UserDefaults.standard.getUserID() else { return }
//        let oldPassword = oldPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        let newPassword = newPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//        let confirmPassword = confirmPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let changePasswordRequest = ChangePasswordRequest(userID: "\(userID)", oldPassword: oldPassword, newPassword: newPassword, confirmPassword: confirmPassword)
//
//        let changePasswordValidation = ChangePasswordValidation()
//        let validationResult = changePasswordValidation.validate(request: changePasswordRequest)
//        if validationResult.success == true{
//            sendRequestForChangePassword(request: changePasswordRequest)
//        }else{
//        DispatchQueue.main.async {
//                self.makeToast(validationResult.error!.localizedDescription)
//            }
//        }
//    }

    @IBAction func onClickNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

      @IBAction func onClickLogout(_ sender: Any) {
          showAlert()
    }

    
    @IBAction func onClickDeleteAccount(_ sender: Any) {
        var refreshAlert = UIAlertController(title: "Do you really want to delete Account", message: "", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.deleteAccount()
//            self.showLoader()
    
    guard let window = UIApplication.shared.keyWindow else {
                  return
      }
//        self.showToast(message: "Your Account Deleted Successfully", font: .systemFont(ofSize: 12.0))
        }))

        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            DispatchQueue.main.async {
                self.hideLoader()
            }
         
          }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func showAlert(){
        DispatchQueue.main.async {
            self.showLoader()
        }
        
        let alert = UIAlertController(title: "Apex Mentality ", message: "Are you sure you want to LogOut ?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            
            DispatchQueue.main.async {
                self.hideLoader()
            }
            print("Handle Ok logic here")
            UserDefaults.standard.removeObject(forKey:"LOGGED_IN")
            let userId = UserDefaults.standard.getUserID()
          
            let userEmailId = UserDefaults.standard.getEmail()
            UserDefaults.standard.removeObject(forKey: userId ?? "")
            UserDefaults.standard.removeObject(forKey: userEmailId ?? "")
            UserDefaults.standard.saveUserRole(userRole:"1")
            //UserDefaults.standard.removeObject(forKey: "userRole")
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
          
            self.setupAppropriateScreen()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            DispatchQueue.main.async {
                self.hideLoader()
            }
            print("Handle Cancel Logic here")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
//DeleteApi
    func deleteAccount()
    {
//        DispatchQueue.main.async {
//        self.showLoader()
//        }
        let apiCall = JsonApi()
        let gmail =  UserDefaults.standard.getEmail()
        let userName = UserDefaults.standard.getUserName()
        let userId =  UserDefaults.standard.getUserID()
        
        let parameters = [
            "user_id": userId!,
//            "user_name": userName!,
            "user_email": gmail!
            ]
                  
         print(parameters)
        apiCall.callUrlSession(urlValue: "https://chawtechsolutions.co.in/dev/apex/api/delete_user.php", para: parameters as (AnyObject), isSuccess: true)
        { (result) -> Void in
            0
            print("service-",result)
            var success = result["success"]
//            UserDefaults.standard.setUserLoggedIn(false)
            UserDefaults.standard.removeObject(forKey:"LOGGED_IN")
            UserDefaults.standard.removeObject(forKey: "user_id")
            UserDefaults.standard.removeObject(forKey: "email")
                     
            let userId = UserDefaults.standard.getUserID()
            let userEmailId = UserDefaults.standard.getEmail()
            UserDefaults.standard.removeObject(forKey: userId ?? "")
            UserDefaults.standard.removeObject(forKey: userEmailId ?? "")
            UserDefaults.standard.saveUserRole(userRole:"1")
            
            //UserDefaults.standard.removeObject(forKey: "userRole")
            
//            guard let window =
//                UIApplication.shared.keyWindow else {
//                return
//            }
                DispatchQueue.main.async {
                 self.hideLoader()
                    self.goToWelcomeVC()

            }
            
//                let options: UIView.AnimationOptions = .transitionCrossDissolve
//                let duration: TimeInterval = 0.5
//                UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
//                { completed in
//                    window.makeKeyAndVisible()
//                })

        }
    }
    
    func goToWelcomeVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeLoginScreen") as! WelcomeLoginScreen
        self.makeToast("Logout successfully")
        let nc = SwipeableNavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 13.0, *) {
            
            UIApplication.shared.windows.first?.rootViewController = nc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            let bounds = UIScreen.main.bounds
            LTY_AppDelegate.window = UIWindow(frame: bounds)
            LTY_AppDelegate.window?.rootViewController = nc
            LTY_AppDelegate.window?.makeKeyAndVisible()
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
    
    func setupAppropriateScreen() {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.makeToast("Logout successfully")
        let nc = SwipeableNavigationController(rootViewController: vc)
        nc.setNavigationBarHidden(true, animated: false)
        
        if #available(iOS 13.0, *) {
            
            UIApplication.shared.windows.first?.rootViewController = nc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            let bounds = UIScreen.main.bounds
            LTY_AppDelegate.window = UIWindow(frame: bounds)
            LTY_AppDelegate.window?.rootViewController = nc
            LTY_AppDelegate.window?.makeKeyAndVisible()
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
    
    
    
    
    
    
    


//        guard let window = UIApplication.shared.keyWindow
//            else {
//                    return
//                }
//        let alert = UIAlertController(title: "DELETE ACCOUNT", message: "Do you want to delete your Account ?", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//
//            print("Handle Ok logic here")
//
//            UserDefaults.standard.setUserLoggedIn(false)
//            UserDefaults.standard.removeObject(forKey: "user_id")
//            UserDefaults.standard.removeObject(forKey: "email")
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//            self.navigationController?.pushViewController(vc, animated: true)
//                 // window.rootViewController = vc
//
//       }))
//        alert
//            .addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//            print("Handle Cancel Logic here")
//        }))
//        present(alert, animated: true, completion: nil)


    @IBAction func onClickProfileSubmit(_ sender: Any) {

    }

    @IBAction func onClickChangePasswordSubmit(_ sender: Any){
    }

        func onClickProfilePicture(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
//        imagePicker.delegate = self
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            imagePicker.sourceType = .camera
            DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
            }
        }

        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default) { _ in
            imagePicker.sourceType = .photoLibrary
            DispatchQueue.main.async {
            self.present(imagePicker, animated: true, completion: nil)
            }
        }
        alert.addAction(cameraAction)
        alert.addAction(photoLibrary)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

// Profile Functions
    @objc func getUserProfile(){
        if UserDefaults.standard.isUserLoggedIn(){
            guard let userID = UserDefaults.standard.getUserID() else { return }
            
            let request = ProfileRequest(userID: Int(userID))
            let profileResource = ProfileResource()
            
            profileResource.getProfile(request: request) { (response) in
                DispatchQueue.main.async {
                    self.refresher.endRefreshing()
                }
                
                if response.success == "true"{
                    self.userProfileData = response.data
                    self.setProfileData(profileData: response.data!)
                }else{
                    DispatchQueue.main.async {
                        self.makeToast(response.message!)
                    }
                }
            } onError: { (error) in
                DispatchQueue.main.async {
                    self.refresher.endRefreshing()
                    self.makeToast(error.localizedDescription)
                }
            }
        }
        else{
            //            self.navigateToLoginViewController()
            //   UserDefaults.standard.setUserLoggedIn(false)
            UserDefaults.standard.removeObject(forKey:"LOGGED_IN")
            UserDefaults.standard.removeObject(forKey: "USER_ID")
            UserDefaults.standard.removeObject(forKey: "EMAIL")
            
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
            window.rootViewController = vc
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.5
            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion:
                                { completed in
                window.makeKeyAndVisible()
            })
        }
    }

    func setProfileData(profileData: ProfileData){
        DispatchQueue.main.async {
//            self.hideSkeleton()
        self.refresher.endRefreshing()
        }
        
        DispatchQueue.main.async {
            self.nameLbl.text = profileData.name
//            self.profileTableView.isScrollEnabled = false
            print(profileData.profileImage)

            if profileData.profileImage != "" {
                print(profileData.profileImage)
//            self.profileImg.kf.setImage(with: URL(string: profileData.profileImage!))
//                self.profileImg.kf.setImage(with: URL(string: "https://chawtechsolutions.co.in//dev//apex//wp-content//uploads//2023//07//IMG_20230727_122615955-scaled.jpg"))


//                self.profileImg.setImage(with: profileData.profileImage ?? "")


        //                self.profilebanner.kf.setImage(with: URL(string: profileData.profileImage!)) { (result) in
//                    switch result{
//                    case .success(_):
//                        break
//
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                    }
//                }

            }else{
              self.profileImg.image = #imageLiteral(resourceName: "empty_image")
        }
}
    }

  
    
    
    //    Profile api Integration
//    func setUserProfileDetails(){
//        if let userProfileData = self.userProfileData{
//            DispatchQueue.main.async {
//            self.nameLbl.text = userProfileData.name
//            self.ProfileNameTxt.text = userProfileData.name
//            self.profileEmailITxt.text = userProfileData.email
//            self.profilePhoneTxt.text = userProfileData.phone
//
//            if userProfileData.profileImage != "" {
//                self.profileImg.kf.setImage(with: URL(string: userProfileData.profileImage!))
//                //                    self.profileBannerImageView.kf.setImage(with: URL(string: userProfileData.profileImage!), completionHandler:  { (result) in
//                //                        switch result{
//                //
//                //                        case .success(_):
//                //                            break
//                //                            //                         self.blurEffect(imageView: self.profileBannerImageView)
//                //                        case .failure(let error):
//                //                            print(error.localizedDescription)
//                //                        }
//                //                    })
//
//            }else{
//                //                    self.profileBannerImageView.contentMode = .scaleAspectFit
//                self.profileImg.image = #imageLiteral(resourceName: "placeholder")
//
//                //                    self.blurEffect(imageView: self.profileBannerImageView)
//            }
//        }
//    }
//        else{
//            print("something went wrong")
//        }
//    }

//    Change Password Api

//    func sendRequestForChangePassword(request: ChangePasswordRequest){
//            DispatchQueue.main.async {
//            showLoading()
//        }
//
//        let profileResource = ProfileResource()
//        profileResource.changePassword(request: request) { (response) in
//                if response.success == "true"{
//                DispatchQueue.main.async {
//                    hideLoading()
//                    self.oldPasswordTxt.text = ""
//                    self.newPasswordTxt.text = ""
//                    self.confirmPasswordTxt.text = ""
//                    self.makeToast(response.message)
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }else{
//                DispatchQueue.main.async {
//                    hideLoading()
//                    self.makeToast(response.message)
//                }
//        }
//
//        } onError: { (error) in
//            DispatchQueue.main.async {
//                hideLoading()
//                self.makeToast(error.localizedDescription)
//            }
//        }
//
//    }

//  hideSkeleton function


}
extension UIViewController {
  func showAlert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

extension UIImageView {
    func setImage(with urlString: String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        kf.indicatorType = .activity
        self.kf.setImage(with: resource)
    }
}


