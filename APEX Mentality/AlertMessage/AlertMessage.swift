//
//  AlertMessage.swift
//  APEX Mentality
//
//  Created by CTS on 19/07/23.
//

import Foundation
import UIKit
import SVProgressHUD
import SPAlert
import SwiftMessages
import Toast_Swift
import Malert

extension UIViewController{
    
    func hideKeyboard(){
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
    
    func hideOfflineMessage(){
        SwiftMessages.hide()
    }
    
    func showOfflineMessage(){
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.configureTheme(.error)
        view.bodyLabel?.text = "OFFLINE"
        
        var config = SwiftMessages.defaultConfig
        config.duration = .forever
        config.dimMode = .gray(interactive: false)
        config.preferredStatusBarStyle = .lightContent
        config.interactiveHide = false
        SwiftMessages.show(config: config, view: view)
        print("Not Connected")
    }
    
    func roundCorners(view :UIView, corners: UIRectCorner, radius: CGFloat){
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func makeToast(_ message: String){
        var style = ToastStyle()
        style.backgroundColor = .black
        style.messageColor = .white
        let windows = UIApplication.shared.windows
        windows.last?.makeToast(message, position: .bottom, style: style)
        
    }
    
    private func createAlertView(title: String?, message: String?) -> Malert{
        
        let customAlertView = HamptonAlertView.instantiateFromNib()
        customAlertView.titleLabel.text = title
        customAlertView.messageLabel.text = message
        customAlertView.messageLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        
        let alert = Malert(customView: customAlertView)
        alert.buttonsSpace = 15
        alert.buttonsAxis = .horizontal
        alert.textAlign = .center
        alert.buttonsSideMargin = 30
        alert.buttonsBottomMargin = 20
        alert.buttonsHeight = 40
        alert.buttonsSpace = 30
        alert.cornerRadius = 3
        alert.presentDuration = 0.3
        alert.dismissDuration = 0.1
        alert.titleFont = UIFont.systemFont(ofSize: 17)
        alert.animationType = .fadeIn
        return alert
    }
    
    func showTwoButtonAlert(title: String?, message: String?, mainButtonTitle: String, action:@escaping() -> Void){
    
        let alert = createAlertView(title: title, message: message)
    
        let cancelButton = MalertAction(title: "Cancel") {
            self.dismiss(animated: true, completion: nil)
        }
        cancelButton.backgroundColor = Colors.lightGray
        cancelButton.borderWidth = 1
        cancelButton.borderColor = Colors.appThemeColor
        cancelButton.tintColor = Colors.appThemeColor
        cancelButton.cornerRadius = 3
        alert.addAction(cancelButton)
        
        let removeButton = MalertAction(title: mainButtonTitle) {
            action()
        }
        removeButton.backgroundColor = Colors.appThemeColor
        removeButton.tintColor = .white
        removeButton.cornerRadius = 3
        alert.addAction(removeButton)
    
        present(alert, animated: true, completion: nil)
    }
        
    func showOKAlertView(title: String, message: String, okAcion:@escaping() -> Void){
        
        let alert = createAlertView(title: title, message: message)
    
        let removeButton = MalertAction(title: "OK") {
            self.dismiss(animated: true, completion: nil)
            okAcion()
        }
        removeButton.backgroundColor = Colors.appThemeColor
        removeButton.tintColor = .white
        removeButton.cornerRadius = 3
        alert.addAction(removeButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showPopUp(title: String, presentStyle: SPAlertIconPreset){
        let alertView = SPAlertView(title: "", message: title, preset: presentStyle)
//        alertView.duration = 1
//        alertView.layout.iconHeight = 40
//        alertView.layout.iconWidth = 40
//        alertView.layout.bottomIconSpace = 10
//        alertView.layout.topSpace = 15
//        alertView.layout.bottomSpace = 15
//        alertView.present()
    }
        func blurEffect(imageView: UIImageView) {
        let context = CIContext(options: nil)
        let currentFilter = CIFilter(name: "CIGaussianBlur")
        let beginImage = CIImage(image: imageView.image!)
        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
        
        let cropFilter = CIFilter(name: "CICrop")
        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
                
        let output = cropFilter!.outputImage
        let cgimg = context.createCGImage(output!, from: output!.extent)
        let processedImage = UIImage(cgImage: cgimg!)
        imageView.image = processedImage
    }
    
//    func navigateToLoginViewController(){
//        UserDefaults.standard.setUserLoggedIn(false)
//        UserDefaults.standard.removeObject(forKey: "USER_ID")
//        UserDefaults.standard.removeObject(forKey: "EMAIL")
//        let loginVC = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        UIApplication.shared.windows.first?.rootViewController = loginVC
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
////        self.navigationController?.popToViewController(loginVC, animated: true)
//         present(loginVC, animated: true, completion: nil)
//    }
    
}

