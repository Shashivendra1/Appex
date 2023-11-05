//
//  ForgotPasswordVC.swift
//  APEX Mentality
//
//  Created by CTS on 19/06/23.
//

import UIKit
import FLAnimatedImage


class ForgotPasswordVC: UIViewController {
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var forgotPaaswordGif: FLAnimatedImageView!
    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.sendBtn.cornerRadius = 10
        if let gifURL = Bundle.main.url(forResource: "forgot-password", withExtension: "gif") {
            if let gifData = try? Data(contentsOf: gifURL) {
                let animatedImage = FLAnimatedImage(animatedGIFData: gifData)
                forgotPaaswordGif.animatedImage = animatedImage
            }
        }
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        let email = emailTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let resetPasswordRequest = ResetPasswordRequest(email: email)
        let resetPasswordValidation = ResetPasswordValidation()
        let validationResult = resetPasswordValidation.validate(request: resetPasswordRequest)
        
        if validationResult.success == true{
            sendResetRequest(request: resetPasswordRequest)
        }else{
            DispatchQueue.main.async {
        self.makeToast(validationResult.error!.localizedDescription)
            }
        }
}
    
    private func sendResetRequest(request: ResetPasswordRequest){
     DispatchQueue.main.async {
            showLoading()
        }
        let profileResource = ProfileResource()
        profileResource.resetPassword(request: request) { (response) in
            if response.success == "true"{
                DispatchQueue.main.async {
                    hideLoading()
        self.emailTxt.text = ""
                    self.navigationController?.popViewController(animated: true)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "OtpVC") as! OtpVC
//    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
//                    self.showOKAlertView(title: "Success", message: response.message) {
//                        self.dismiss(animated: true, completion: nil)
//                    }
                }
            }else{
                DispatchQueue.main.async {
                    hideLoading()
                    self.makeToast(response.message)
                }
            }
        } onError: { (error) in
            DispatchQueue.main.async {
                hideLoading()
                self.makeToast(error.localizedDescription)
            }
        }
    }
    
    @IBAction func onClickBackToLogin(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
//   let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
// self.navigationController?.pushViewController(vc, animated: true)
}
    
    @IBAction func onClickBack(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
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

