//
//  WelcomeLoginVC.swift
//  APEX Mentality
//
//  Created by CTS on 15/06/23.
//

import UIKit
class WelcomeLoginVC: UIViewController {
    override func viewDidLoad() {
    super.viewDidLoad()
}
    
    @IBAction func onClickWelcomeLogin(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
