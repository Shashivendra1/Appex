//
//  clientLoginVC.swift
//  APEX Mentality
//
//  Created by CTS on 19/06/23.
//

import UIKit

class clientLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func onClickSignup(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as! SignupVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
