//
//  SignupVC.swift
//  APEX Mentality
//
//  Created by CTS on 14/06/23.
//

import UIKit
import FLAnimatedImage
import MBProgressHUD
class SignupVC: UIViewController {

    @IBOutlet weak var gifImage: FLAnimatedImageView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var emailAddressTxt: UITextField!
    @IBOutlet weak var phoneNoTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    @IBOutlet weak var signUpBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signUpBtn.layer.cornerRadius = 10
        hideKeyboardWhenTappedAround()
    if let gifURL = Bundle.main.url(forResource: "signup", withExtension: "gif") {
        if let gifData = try? Data(contentsOf: gifURL) {
                    let animatedImage = FLAnimatedImage(animatedGIFData: gifData)
            gifImage.animatedImage = animatedImage
                }
        }
        passwordTxt.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        self.firstNameTxt.layer.cornerRadius = 10
        self.firstNameTxt.layer.borderWidth = 1
        self.firstNameTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.lastNameTxt.layer.cornerRadius = 10
        self.lastNameTxt.layer.borderWidth = 1
        self.lastNameTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.emailAddressTxt.layer.cornerRadius = 10
        self.emailAddressTxt.layer.borderWidth = 1
        self.emailAddressTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.phoneNoTxt.layer.cornerRadius = 10
        self.phoneNoTxt.layer.borderWidth = 1
        self.phoneNoTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.passwordTxt.layer.cornerRadius = 10
        self.passwordTxt.layer.borderWidth = 1
        self.passwordTxt.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        self.confirmPassword.layer.cornerRadius = 10
        self.confirmPassword.layer.borderWidth = 1
        self.confirmPassword.layer.borderColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1).cgColor

    }
        
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickEyeToggleBtn(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxt.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func onClickEyeToggleBtn2(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    confirmPassword.isSecureTextEntry = !sender.isSelected
    }
        
    
    @IBAction func onClickSignUp(_ sender: Any) {
        let FirstName = firstNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailAddress = emailAddressTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneNo = phoneNoTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        guard ((phoneNo?.isLengthValid(minLength: 10, maxLength: 13)) != nil) else  {
                   self.makeToast("Please enter a valid Phone Number")
                   return
               }
        let password = passwordTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
      
        
        
        let confirmPassword = confirmPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let signupRequest = SignUpRequest(name: FirstName, lastName: lastName, email: emailAddress, phone: phoneNo, password: password, confirmPassword: confirmPassword)
        
        let signUpValidation = SignUpValidation()
        let validationResult = signUpValidation.validate(request: signupRequest)
        if validationResult.success{
            sendSignUpRequestToServer(request: signupRequest)
        }else{
            DispatchQueue.main.async {
                self.makeToast(validationResult.error!.localizedDescription)
            }
        }
    }
    
    func sendSignUpRequestToServer(request: SignUpRequest){
          DispatchQueue.main.async {
            self.showLoader()
      }
      let signupResource = SignUpResource()
      signupResource.signUp(request: request) { (response) in
          if response.success == "true"{
              DispatchQueue.main.async {
                  self.hideLoader()
                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                  self.makeToast("Signup Successfully")
                  self.navigationController?.pushViewController(vc, animated: true)
//                  UserDefaults.standard.setUserLoggedIn(true)
//                  UserDefaults.standard.saveUserID(userID: "\((response.data?.userID)!)")
//                  UserDefaults.standard.saveEmail(email: (response.data?.email)!)
//                  UserDefaults.standard.saveUserName(userName: (response.data?.name)!)
                  UIApplication.shared.windows.first?.rootViewController = vc
                  UIApplication.shared.windows.first?.makeKeyAndVisible()
                 
                  self.present(vc, animated: true, completion: nil)
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

    
    
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
