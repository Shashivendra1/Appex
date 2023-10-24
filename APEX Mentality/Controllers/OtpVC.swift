//
//  OtpVC.swift
//  APEX Mentality
//
//  Created by CTS on 25/07/23.
//

import UIKit
class OtpVC: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var newPassEye: UIButton!
    
    @IBOutlet weak var confirmPassEye: UIButton!
    
    @IBOutlet weak var TXT1: UITextField!
    
    @IBOutlet weak var TXT2: UITextField!
    
    @IBOutlet weak var TXT3: UITextField!
    
    @IBOutlet weak var TXT4: UITextField!
    
    @IBOutlet weak var TXT5: UITextField!
    
    @IBOutlet weak var TXT6: UITextField!
    
    @IBOutlet weak var newPassTxt: UITextField!
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    
    @IBOutlet weak var setOtpBtn: UIButton!
        
    @IBOutlet weak var cacleBtn: UIButton!
        
    @IBOutlet weak var timerLbl: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        self.setOtpBtn.layer.cornerRadius = 20
        self.cacleBtn.layer.cornerRadius = 20
        newPassTxt.isSecureTextEntry = true
        confirmPassTxt.isSecureTextEntry = true
        TXT1.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
           
        TXT2.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
            
            
        TXT3.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        
        TXT4.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        
        TXT5.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
        
        TXT6.addTarget(self, action: #selector(self.textdidChange(textfield:)), for: UIControl.Event.editingChanged)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TXT1.becomeFirstResponder()
    }
        @objc func textdidChange(textfield: UITextField){
        let text = textfield.text
        if text?.utf16.count == 1{
            switch textfield {
            case TXT1: TXT2.becomeFirstResponder()
                break
            case TXT2: TXT3.becomeFirstResponder()
                break
            case TXT3: TXT4.becomeFirstResponder()
                break
            case TXT4: TXT5.becomeFirstResponder()
                break
            case TXT5: TXT6.becomeFirstResponder()
                break
            case TXT1: TXT2.becomeFirstResponder()
                break
            default:
             print("error")
            }
    }

    }
    @IBAction func onClickNewPassEyeToggle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        newPassTxt.isSecureTextEntry = !sender.isSelected
    }
    
    
    @IBAction func onClickConfirmPasswordEyeToggle(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        confirmPassTxt.isSecureTextEntry = !sender.isSelected
    }
    
    @IBAction func onClickSetPassword(_ sender: Any) {
    }
    
    @IBAction func onClickCancle(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
//    func countDownTime() {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
//                    self.timerLbl.isHidden = false
//            self.resendOTPBtn.isEnabled = false
//            if self.timerLabel.isHidden == false {
//                self.startTimer()
//            } else {
//                self.countdownTimer.invalidate()
//                self.resendOTPBtn.isEnabled = true
//                self.timerLabel.isHidden = true
//
//            }
//            }
//        }

//    func startTimer() {
//              countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//
//          }
    
//    @objc func updateTime() {
//            DispatchQueue.main.async(){
//                self.timerLbl.text = self.timeFormatted(self.totalTime)
//                    if self.totalTime != 0 {
//                    self.totalTime -= 1
//                } else {
//                    print("Invalidated")
//                    self.endTimer()
//
//                }
//        }
//            }
    
//    func timeFormatted(_ totalSeconds: Int) -> String {
//                let seconds: Int = totalSeconds % 60
//                let minutes: Int = (totalSeconds / 60) % 60
//            //     let hours: Int = totalSeconds / 3600
//                return String(format: "%02d:%02d", minutes, seconds)
//            }
    
    
}
