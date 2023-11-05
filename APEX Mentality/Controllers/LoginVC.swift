//
//  loginVC.swift
//  APEX Mentality


import UIKit
import Firebase
import Kingfisher
import FLAnimatedImage
import MBProgressHUD

class LoginVC: UIViewController {
    
    @IBOutlet weak var coachLoginImg: UIImageView!
    @IBOutlet weak var clientLoginImg: UIImageView!
    @IBOutlet weak var coachLoginBtn: UIButton!
    @IBOutlet weak var clientLoginBtn: UIButton!
    @IBOutlet weak var gifImage: FLAnimatedImageView!
    @IBOutlet weak var coachLoginView: UIView!
    @IBOutlet weak var clientLoginView: UIView!
    @IBOutlet weak var coachEmailTxt: UITextField!
    @IBOutlet weak var coachPasswordTxt: UITextField!
    @IBOutlet weak var clientEmailTxt: UITextField!
    @IBOutlet weak var clientPasswordTxt: UITextField!
    @IBOutlet weak var coachLoginLbl: UILabel!
    @IBOutlet weak var clientLoginLbl: UILabel!
    @IBOutlet weak var coachLoginRef: UIButton!
    @IBOutlet weak var StackView: UIStackView!
    @IBOutlet weak var clientEyeBtn: UIButton!
    @IBOutlet weak var coachEyeBtn: UIButton!
    @IBOutlet weak var clientLoginBtnOutlet: UIButton!
    @IBOutlet weak var coachLoginBtnOutlet: UIButton!
    
    var fcm_key:String = ""
    var coachActive:Bool = false
    var clientActive:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.clientLoginBtnOutlet.cornerRadius = 10
        self.coachLoginBtnOutlet.cornerRadius = 10
        
        coachPasswordTxt.isSecureTextEntry = true
        clientPasswordTxt.isSecureTextEntry = true
                
        hideKeyboardWhenTappedAround()
        self.coachLoginLbl.layer.cornerRadius = 10
        self.clientLoginLbl.layer.cornerRadius = 10
        self.coachLoginBtn.layer.cornerRadius = 10
        self.clientLoginBtn.layer.cornerRadius = 10
        self.clientLoginLbl.layer.cornerRadius = 10
        self.StackView.layer.cornerRadius = 10
        self.coachLoginLbl.layer.masksToBounds = true
        self.clientLoginLbl.layer.masksToBounds = true
        self.coachLoginBtn.layer.masksToBounds = true
        self.clientLoginBtn.layer.masksToBounds = true
        
        coachLoginLbl.textColor =  UIColor.white
        coachLoginLbl.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        clientLoginLbl.textColor = UIColor.black
        clientLoginLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        coachActive = true
        clientActive = false
        textFieldBorder()
        clientLoginView.isHidden = true
        
        if let gifURL = Bundle.main.url(forResource: "login", withExtension: "gif") {
            if let gifData = try? Data(contentsOf: gifURL) {
                let animatedImage = FLAnimatedImage(animatedGIFData: gifData)
                gifImage.animatedImage = animatedImage
            }
        }
   
    }
    
     
    private func CheckPlanApi(request: CheckSubscriptionPlanRequest){
        let userDict = [
            "userId": request.userID,
        ]
        
        print(userDict)
        
        //        let coachDict = [request.email , request.password , request.fcm_key]
        
        DispatchQueue.main.async {
            showLoading()
        }
        let loginResource = CheckPlanResources()
        self.plan(request: request) { (response) in
            print(response)
            if response.success == "true"{
                UserDefaults.standard.set("no", forKey: "showSubscription")
             
                DispatchQueue.main.async {
                    self.switchToTab()
                }
            }else{
                UserDefaults.standard.set("yes", forKey: "showSubscription")

               
                DispatchQueue.main.async {
                    self.switchToTab()
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            } }
    }
    
    func plan(request: CheckSubscriptionPlanRequest, onSuccess:@escaping (_ result: CheckSubscriptionPlanResponse) -> Void, onError:@escaping(_ error: Error) -> Void){
        do {
            let requestBody = try JSONEncoder().encode(request)
            HttpUtility.shared.postRequest(urlString: APIs.PAYMENT_SUBSCRIPTION, requestBody: requestBody, resultType: CheckSubscriptionPlanResponse.self) { (result) in
                switch result{
                case .success(let response):
                    onSuccess(response)
                case .failure(let error):
                    onError(error)
                }
            }
        } catch let error {
            onError(error)
        }
    }

    
    @IBAction func onClickCoachLogin(_ sender: Any) {
        if coachActive {
            coachActive = true
            coachLoginLbl.textColor = UIColor.white
            coachLoginLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            
            clientLoginLbl.textColor = UIColor.black
            clientLoginLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
        }else {
            clientActive = true
            coachLoginLbl.textColor = UIColor.black
            coachLoginLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            
            clientLoginLbl.textColor = UIColor.white
            clientLoginLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            
        }
        coachLoginView.isHidden = false
        clientLoginView.isHidden = true
    }
    
    @IBAction func onClickCoachEyeToggleBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        coachPasswordTxt.isSecureTextEntry = !sender.isSelected
    }
    

    @IBAction func onClickClientEyeToggleBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        clientPasswordTxt.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func onClickClientLogin(_ sender: Any) {
        if clientActive {
            clientActive = true
            clientLoginLbl.textColor = UIColor.white
            clientLoginLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            
            coachLoginLbl.textColor = UIColor.black
            coachLoginLbl.backgroundColor = UIColor(red: 255/255, green: 2555/255, blue: 255/255, alpha: 1)
            
        }else {
            coachActive = true
            coachLoginLbl.textColor = UIColor.black
            coachLoginLbl.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            clientLoginLbl.textColor = UIColor.white
            clientLoginLbl.backgroundColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
        }
        
        coachLoginView.isHidden = true
        clientLoginView.isHidden = false
    }
    
    @IBAction func onClickSignup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickForgotPassword(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
        
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onClickCoachLoginAction(_ sender: Any) {
        hideKeyboard()
        let ProfilePc = UserDefaults.standard.getProfile()
        let namee = UserDefaults.standard.getUserName()
        let fcmToken =  UserDefaults.standard.getFcmToken()
        let email = coachEmailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passsword = coachPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let loginRequest = LoginRequest(name : namee, email: email, password: passsword, fcm_key: fcmToken, device: "iOS" , login_type: "coache" , profilePC: ProfilePc)
        let loginValidation = LoginValidation()
        let validationResult = loginValidation.validate(request: loginRequest)
        if validationResult.success{
            sendLoginRequestToServer(request: loginRequest)
        }else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
    }
    
    @IBAction func onClickCLogin(_ sender: Any) {
        hideKeyboard()
        let email = clientEmailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let passsword = clientPasswordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let fcmToken = UserDefaults.standard.getFcmToken()
        let loginRequest = LoginRequest(email: email, password: passsword, fcm_key: fcmToken, device: "iOS" , login_type: "client")
        let loginValidation = LoginValidation()
        let validationResult = loginValidation.validate(request: loginRequest)
        
        if validationResult.success{
            sendLoginRequestToServer(request: loginRequest)
        }else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
    }
    
    func textFieldBorder(){
        self.coachEmailTxt.layer.borderWidth = 1
        self.coachEmailTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.coachEmailTxt.layer.cornerRadius = 10
        self.coachPasswordTxt.layer.borderWidth = 1
        self.coachPasswordTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.coachPasswordTxt.layer.cornerRadius = 10
        self.clientEmailTxt.layer.borderWidth = 1
        self.clientEmailTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.clientEmailTxt.layer.cornerRadius = 10
        self.clientPasswordTxt.layer.borderWidth = 1
        self.clientPasswordTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.clientPasswordTxt.layer.cornerRadius = 10
    }
    
    
 private func sendLoginRequestToServer(request: LoginRequest){
            let userDict = [
            "email": request.email,
            "fcmKey" : request.fcm_key ,
            "usertype" : request.login_type,
            "userName"   :request.name,
            "profilePic" : request.profilePC]
        
           print(userDict)
     
//        let coachDict = [request.email , request.password , request.fcm_key]
        
        DispatchQueue.main.async {
            self.showLoader()
//            showLoading()
        }
        let loginResource = LoginResource()
        loginResource.login(request: request) { (response) in
            print(response)
            if response.success == "true"{
                DispatchQueue.main.async {
                    self.hideLoader()
                }
               
               // guard let userId = UserDefaults.standard.getUserID()else{return }
                print("\((response.data?.userID)!)")
                
                let userDict1 = [
                "email": request.email,
                "fcmKey" : request.fcm_key ,
                "usertype" : request.login_type,
                "userName"   :response.data?.name ?? "",
                "profilePic" : response.data?.profilePC ?? ""]
                
                print(userDict1)
                
                Database.database().reference().child("users").child("\((response.data?.userID)!)").updateChildValues(userDict1 as [AnyHashable : Any])
//        Database.database().reference().child("users").updateChildValues(userDict as [AnyHashable : Any])
                                
            DispatchQueue.main.async {
                self.hideLoader()
            if  response.data?.userRole == "coache"{
            //                        if self.coachLoginRef.isSelected == true {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "coachMessageVC") as! coachMessageVC
                                vc.comingFrom = "LoginVC"
         
                    self.makeToast("Login Successfully")
        self.navigationController?.pushViewController(vc, animated: true)
              
//                            hideLoading()
                    } else {
                        DispatchQueue.main.async {
                            self.hideLoader()
                        }
                       
//                       hideLoading()
//                        self.switchToTab()
                        self.CheckPlanApi(request: CheckSubscriptionPlanRequest.init(userID: (response.data?.userID)!))
                    }
  
                    UserDefaults.standard.setUserLoggedIn(true)
                    UserDefaults.standard.saveUserID(userID: "\((response.data?.userID)!)")
                    UserDefaults.standard.saveEmail(email: (response.data?.email)!)
                    UserDefaults.standard.saveUserName(userName: (response.data?.name)!)
                    
                    UserDefaults.standard.savePhoneNo(phoneNo: (response.data?.phone)!)
                   
                    
                    UserDefaults.standard.saveProfilePic(profile:(response.data?.profilePC)!)
                    
                UserDefaults.standard.saveUserRole(userRole: (response.data?.userRole)!)
                    
              }
            }else{
                DispatchQueue.main.async {
                    self.hideLoader()
                    self.makeToast(response.message!)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                self.hideLoader()
                self.makeToast(error.localizedDescription)
            } }
    }
        
    func switchToTab() {
        let vc = TabBarViewController.instantiate(fromAppStoryboard: .main)
        
        // vc.selectedIndex = selectedIndex ?? 0
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
        LTY_AppDelegate.window?.rootViewController = vc
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
