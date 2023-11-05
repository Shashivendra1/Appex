//
//  SubscriptionPopUpVc.swift
//  APEX Mentality
//
//  Created by CTS on 12/09/23.
//


import UIKit
import StoreKit
import SVProgressHUD

protocol SubscriptionProtocolDelegate{
    func subscription(setValue:String)
}

class SubscriptionPopUpVc: UIViewController, UIGestureRecognizerDelegate  , SKPaymentTransactionObserver {
    var subscriptionDelegate : SubscriptionProtocolDelegate?
    
    @IBOutlet weak var membrshipOutlet: UILabel!
    
    @IBOutlet weak var validDateOutlet: UILabel!
    
    @IBOutlet weak var totalAmountOutlet: UILabel!
    
    @IBOutlet weak var payNowAmountLbl: UILabel!
    
    //var products = [SKProduct]()
    var isNewPurchase = false
    let paymentQueue = SKPaymentQueue.default()
    
    var comingFromMonthly = ""
    var comingFromHalfYearly = ""
    var comingFromYearly =  ""
    var currentDate = ""
    var validDate = ""
    var planId = ""
    var planName = ""
    
    
    var membership = ""
    var totalAmount = ""
    
    var indexP = Int()
    var price = ""
    var Packagename = ""
    var Terms = ""
    var discount = ""
    var id = ""
    var enabled = 0
    
    var products = [IAProduct]()
    var paymentModel = [IAProduct]()

    let MonthlyProductId = "com.test.monthly"
    let halfYearlyProductId = "com.test.halfyearly"
    let yearlyProductId  = "com.test.yearly"
    
        override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
//      purchaseLbl.text = "purchase not complete yet"
      
            
        let userId = UserDefaults.standard.getUserID()
        self.membrshipOutlet.text = membership
        self.validDateOutlet.text = "Valid till \(validDate)"
        self.totalAmountOutlet.text = totalAmount
        self.payNowAmountLbl.text = totalAmount
            
        
   let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    superView.addGestureRecognizer(tap)
 }
    
    @IBOutlet var superView: UIView!
        
    @IBAction func onClickPayNow(_ sender: Any) {
        
        IAPService.shared.planId = self.planId
        IAPService.shared.planName = self.planName
        IAPService.shared.currentDate = self.currentDate
        IAPService.shared.validDate = self.validDate
     //   IAPService.shared.totalAmount = self.totalAmount
        
        let characterToRemove: Character = "$"
        let filteredString = String(self.totalAmount.filter { $0 != characterToRemove })
       // print(filteredString)
        
        IAPService.shared.totalAmount = filteredString
        //replacingOccurrences(of: "$", with: "", options: NSString.CompareOptions.literal, range: nil)

        
        self.dismiss(animated: true) {
            if SKPaymentQueue.canMakePayments(){
            let paymentRequest = SKMutablePayment()
                if self.totalAmount == "$12.99"{
                   // paymentRequest.productIdentifier = self.MonthlyProductId
                    IAPService.shared.purchase(product: .Subscription1)
                    
            }
                else if self.totalAmount == "$60.99"{
//                    paymentRequest.productIdentifier = self.halfYearlyProductId
                    IAPService.shared.purchase(product: .Subscription2)
            }
                else{
//                    paymentRequest.productIdentifier = self.yearlyProductId
                    IAPService.shared.purchase(product: .Subscription3)
                }
//                SKPaymentQueue.default().add(paymentRequest)
            }else{
                print("user unable to make payment")
        }

        }


  }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.dismiss(animated: true)
    }
    
    
// func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions {
//        if transaction.transactionState == .purchased{
//        print("Transaction succes")
//        subscriptionApi()
////      purchaseLbl.text = "Purchase complete"
//    }
//        else if transaction.transactionState == .failed{
//        print("Transaction failed")
//                }
//            }
//        }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        var count = 0
        for transaction in transactions {
            count += 1
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            
            switch transaction.transactionState {
            case .purchasing:
                break
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .purchased:
                print("Purchased on Date:- ", transaction.transactionDate!)
                
                if count == 1 {
//                    receiptValidation()
                }
                
//                subscriptionApi()
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    if self.isSubscriptionPurchased == "monthly" || self.isSubscriptionPurchased == "annual" {
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SubscriptionPurchased"), object: nil)
//                    } else if self.isSubscriptionPurchased == "payPerClick"{
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "payPerClickPurchased"), object: nil)
//                    } else if self.isSubscriptionPurchased == "newUserPlan"{
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newUserPlanPurchased"), object: nil)
//                    } else {
//                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "QuestionairePurchased"), object: nil)
//                    }
//
//                }
               
                paymentQueue.finishTransaction(transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            default:
                
                queue.finishTransaction(transaction)
                break
            }
        }
    }
}


extension SubscriptionPopUpVc{
func subscriptionApi(){
        let UserId = UserDefaults.standard.getUserID()
        let apiCall = JsonApi()
        let parameters = [
            "user_id": UserId,
            "price": totalAmount,
            "status": "Confirm",
            "plan_id": planId,
            "planname": planName,
            "pay_date": currentDate,
            "expiry_date":validDate
        ] as [String : Any]
         print(parameters)
        apiCall.callUrlSession(urlValue: "https://chawtechsolutions.co.in/dev/apex/api/userpayment.php", para: parameters as (AnyObject), isSuccess: true)
        { (result) -> Void in
        print("service-",result)
         var success = result["success"]
            
            DispatchQueue.main.async {
                
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CoachesRequestVC") as! CoachesRequestVC
//        self.navigationController?.present(vc, animated: true, completion: nil)
        self.navigationController?.pushViewController(vc, animated: true)
//           self.hideLoader()
        
        }

        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//        if Reachability.isConnectedToNetwork() {
////            showProgressOnView(self.view)
//             showLoading()
//            let param:[String:Any] = ["subscriptionId":subsciptionId]
//            //          let param:[String:Any] = [:]
//            print(subsciptionId)
//
//            ServerClass.sharedInstance.postRequestWithUrlParameters2(param, path: BASE_URL + PROJECT_URL.IN_APP_PURCHASE_VERIFY_API, successBlock: { (json) in
//
//                print(json)
//                hideProgressOnView(self.view)
//                let success = json["code"].stringValue
//                if success  == "E0000" {
//                    let frontendmessage = json["frontendmessage"].stringValue
//
//                    let Alert = UIAlertController(title: "Message", message: frontendmessage, preferredStyle: UIAlertController.Style.alert)
//                    Alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//                        DispatchQueue.main.async{
//                            self.navigationController?.popViewController(animated: true)
//                            //                            if let VC = self.storyboard?.instantiateViewController(withIdentifier: "tab"){
//                            //                                //self.modalPresentationStyle = .fullScreen
//                            //                                VC.modalPresentationStyle = .fullScreen
//                            //                                self.navigationController?.present(VC, animated: true)
//                            //                            }
//                        }
//                    }))
//
//                    DispatchQueue.main.async {
//                        self.present(Alert, animated: true, completion: nil)
//                    }
//                }else {
//                    UIAlertController.showInfoAlertWithTitle("Alert", message: json["frontendmessage"].stringValue, buttonTitle: "Okay")
//
//                }
//            }, errorBlock: { (NSError) in
//                UIAlertController.showInfoAlertWithTitle("Alert", message: kUnexpectedErrorAlertString, buttonTitle: "Okay")
//                hideProgressOnView(self.view)
//            })
//        }
//        else{
//            UIAlertController.showInfoAlertWithTitle("Alert", message: "Please Check internet connection", buttonTitle: "Okay")
//        }
//
}
