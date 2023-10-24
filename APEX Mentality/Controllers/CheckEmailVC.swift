//
//  CheckEmailVC.swift
//  APEX Mentality
//
//  Created by CTS on 20/07/23.
//

import UIKit
class CheckEmailVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onClickOk(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
