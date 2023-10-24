//
//  WelcomeLoginScreen.swift
//  APEX Mentality
//
//  Created by CTS on 12/07/23.
//


import UIKit
class WelcomeLoginScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickWelcomeLogin(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
        {
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        }
        }
    }

