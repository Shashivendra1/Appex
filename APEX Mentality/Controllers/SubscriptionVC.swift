//
//  SubscriptionVC.swift
//  APEX Mentality
//
//  Created by CTS-Puja  on 27/06/23.
//

import UIKit

class SubscriptionVC: UIViewController {
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var paynowView: UIView!
    @IBOutlet weak var paynowBtn: UIButton!
    @IBOutlet weak var membershipView: UIView!
    
    @IBOutlet weak var monthlySubscriptionBtn: UIButton!
        
    @IBOutlet weak var halfYearlySubscription: UIButton!
    
    @IBOutlet weak var yearlySubscriptionBtn: UIButton!
   
    
    @IBOutlet weak var MonthlyView: UIView!
    
    @IBOutlet weak var mothlyPaymentDollerView: UIView!
    
    @IBOutlet weak var halfYearlyView: UIView!
    
    @IBOutlet weak var halfYearlyPaymmentDollerView: UIView!
    
    @IBOutlet weak var yearlyView: UIView!
    
    @IBOutlet weak var yearlyPaymentDollerView: UIView!
    
    var subsriptionType  = ""
    var currenttDate :String = ""
    var monthlyValidDate:String = ""
    var halfYearlyValidDate:String = ""
    var yearlyValidDate :String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let currentDateStr = dateFormatter.string(from: currentDate)

        currenttDate = currentDateStr
//        let expiryDateFormat = 29
//        var expiryDateValue = Int()
//    if let currentDateFormat = Int(currentDateStr) {
//            expiryDateValue = currentDateFormat - expiryDateFormat
//              print("Result: \(expiryDateValue)")
//        } else {
//             print("The string is not a valid integer.")
//        }
        
        let month = 30
        let calendar = Calendar.current
        
        if let expiryDate = calendar.date(byAdding: .day, value: month, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var MonthlyformattedExpiryDate = dateFormatter.string(from: expiryDate)
            monthlyValidDate =  MonthlyformattedExpiryDate
           print("Expiry Date: \(MonthlyformattedExpiryDate)")
        } else {
           print("Unable to calculate the expiry date.")
    }
        
         let halfYearly = 180
         if let expiryDate = calendar.date(byAdding: .day, value: halfYearly, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var HalfYearlyformattedExpiryDate = dateFormatter.string(from: expiryDate)
           halfYearlyValidDate =  HalfYearlyformattedExpiryDate
            
           print("Expiry Date: \(HalfYearlyformattedExpiryDate)")
        } else {
           print("Unable to calculate the expiry date.")
    }
        
        let yearly = 365
        if let expiryDate = calendar.date(byAdding: .day, value: yearly, to: currentDate) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            var yearlyformattedExpiryDate = dateFormatter.string(from: expiryDate)
          yearlyValidDate =   yearlyformattedExpiryDate
            
           print("Expiry Date: \(yearlyformattedExpiryDate)")
        } else {
           print("Unable to calculate the expiry date.")
    }
        
        
        self.MonthlyView.layer.cornerRadius = 10
        self.halfYearlyView.layer.cornerRadius = 10
        self.yearlyView.layer.cornerRadius = 10
        
        self.mothlyPaymentDollerView.layer.cornerRadius = 5
        self.mothlyPaymentDollerView.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        self.mothlyPaymentDollerView.layer.borderWidth = 2
        
        
        self.halfYearlyPaymmentDollerView.layer.cornerRadius = 5
        self.halfYearlyPaymmentDollerView.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        self.halfYearlyPaymmentDollerView.layer.borderWidth = 2
        
        self.yearlyPaymentDollerView.layer.cornerRadius = 5
        self.yearlyPaymentDollerView.layer.borderColor = UIColor(red: 223/255, green: 223/255, blue: 223/255, alpha: 1).cgColor
        self.yearlyPaymentDollerView.layer.borderWidth = 2
        
//        self.popView.isHidden = true
//        self.membershipView.layer.cornerRadius = 20
//        self.paynowBtn.layer.cornerRadius = 20
//        self.paynowView.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.makeToast("You don't have any plan")
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
 }
    
  @IBAction func onClickPayNow(_ sender: Any) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CoachesRequestVC") as! CoachesRequestVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickMonthlySubBtn(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionPopUpVc") as! SubscriptionPopUpVc
        self.subsriptionType = "1"
        
        if  self.subsriptionType == "1"{
            vc.membership = "1 Month Membership"
            vc.currentDate = currenttDate
            vc.validDate = monthlyValidDate
            vc.totalAmount = "$12.99"
            vc.planId = "com.test.monthly"
            vc.planName = "Monthly"
            vc.subscriptionDelegate = self
            
        }

        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onClickHalfYearly(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionPopUpVc") as! SubscriptionPopUpVc
        self.subsriptionType = "2"
        if self.subsriptionType == "2"{
            vc.membership = "6 month Membership"
            vc.currentDate = currenttDate
            vc.validDate = halfYearlyValidDate
            vc.totalAmount = "$60.99"
            vc.planId = "com.test.halfyearly"
            vc.planName = "halfYearly"
            vc.subscriptionDelegate = self
            
}
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
        
    
    @IBAction func onClickYearly(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionPopUpVc") as! SubscriptionPopUpVc
        self.subsriptionType = "3"
        if  self.subsriptionType == "3" {
            vc.subscriptionDelegate = self
            vc.membership = "1 year Membership"
            vc.currentDate = currenttDate
            vc.validDate = yearlyValidDate
            vc.planId = "com.test.yearly"
            vc.totalAmount = "$100.99"
            vc.planName = "yearly"
            
        }
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func onClickCrossbtn(_ sender: Any) {
        self.popView.isHidden = true
    }

    
    @IBAction func onClickNotification(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVC") as! NotificationVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SubscriptionVC: SubscriptionProtocolDelegate{
    func subscription(setValue: String) {
        let registerView = self.storyboard?.instantiateViewController(withIdentifier: "CoachesRequestVC") as! CoachesRequestVC
self.navigationController?.pushViewController(registerView, animated: true)
        
    }
    
    
    
}
