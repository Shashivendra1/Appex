//
//  NeedHelpTabVC.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//

import UIKit

class NeedHelpTabVC: UIViewController {

    @IBOutlet weak var nameView: UIView!
        
    @IBOutlet weak var emailView: UIView!
    
    @IBOutlet weak var phoneView: UIView!
    
    @IBOutlet weak var messageView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let shadowPath = UIBezierPath(rect: self.nameView.layer.bounds)
        self.nameView.layer.masksToBounds = false
        self.nameView.layer.shadowColor = CGColor(red: 255/3, green: 255/6, blue: 255/5, alpha: 1)
        self.nameView.layer.shadowOffset = CGSizeMake(0.0, -2.0)
        self.nameView.layer.shadowOpacity = 0.3
        self.nameView.layer.shadowRadius = 1.0
        self.nameView.layer.shadowPath = shadowPath.cgPath
        
       
        
        
               nameView.translatesAutoresizingMaskIntoConstraints = false
               let horizontalConstraint = nameView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
               let verticalConstraint = nameView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
               let widthConstraint = nameView.widthAnchor.constraint(equalToConstant: 100)
               let heightConstraint = nameView.heightAnchor.constraint(equalToConstant: 100)
               NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        
        
        

        self.nameView.layer.cornerRadius = 20
        self.emailView.layer.cornerRadius = 20
        self.phoneView.layer.cornerRadius = 20
        self.messageView.layer.cornerRadius = 20
        
        
       
    }
    


    
    @IBAction func onClickNotification(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
