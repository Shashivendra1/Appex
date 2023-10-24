//
//  IAPService.swift
//  TeamPlayer
//
//  Created by ChawTech Solutions on 16/08/22.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    override init() {
        super.init()
        //Other initialization here.
    }
    static let shared = IAPService()
    
    var currentDate = ""
    var validDate = ""
    var planId = ""
    var planName = ""
    var totalAmount = ""
    
    
    
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    var isNewPurchase = false
    var isrestored = false
    var isSubscriptionPurchased = ""
    #if DEBUG
    let verifyReceiptURL = "https://sandbox.itunes.apple.com/verifyReceipt"
    #else
    let verifyReceiptURL = "https://buy.itunes.apple.com/verifyReceipt"
    #endif
    func getProducts() {
        SKPaymentQueue.default().add(self)

        let products: Set = [IAPProducts.Subscription1.rawValue, IAPProducts.Subscription2.rawValue, IAPProducts.Subscription3.rawValue]
        //let products: Set = ["testing_course"]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func getCourseProducts(id:String) {
        let products: Set = [id]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }
    
    func videoPurchase(product: String) {
        isNewPurchase = true
        guard let productToPurchase = products.filter({ $0.productIdentifier == product }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
        
    }
    
    func getVideoProducts(id:String) {
        let products: Set = [id]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
        paymentQueue.add(self)
    }

    func purchase(product: IAPProducts) {
        isNewPurchase = true
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
    func coursePurchase(product: String) {
        isNewPurchase = true
        guard let productToPurchase = products.filter({ $0.productIdentifier == product }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
        
    }
    
    func restorePurchases() {
        print("restore purchases")
        paymentQueue.restoreCompletedTransactions()
    
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
}

extension IAPService: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        products = response.products
        for product in response.products {
            print(product)
            print(product.price)
            print(product.priceLocale)
//            print(product.localizedPrice)
            
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        for transaction in queue.transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            
            switch transaction.transactionState {
            case .purchasing: break
            default: queue.finishTransaction(transaction)
            }
        }
    }
    
   
    
}

extension IAPService: SKPaymentTransactionObserver {
    
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
                showSubscription = false
                let paymentDict:[AnyHashable:Any] = ["planId":self.planId,"planName":self.planName,"currentDate":self.currentDate,"validDate":self.validDate,"totalAmount":self.totalAmount]

         
            //   NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SubscriptionPurchased"), object: nil,userInfo: paymentDict)
                
                if count == 1 {
                    receiptValidation()
                }
                
                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//
//                    self.switchToTab(false)
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
    func receiptValidation() {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd/MM/yyyy"
        let receiptFileURL = Bundle.main.appStoreReceiptURL
        let receiptData = try? Data(contentsOf: receiptFileURL!)
        let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        if recieptString == nil {
            restorePurchases()
            isrestored = true
            return
        }
        let jsonDict: [String: AnyObject] = ["receipt-data" : recieptString! as AnyObject, "password" : "9eff2b6603224f9fb9ade74cfcfb78ba" as AnyObject]
        
        do {
            let requestData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
            let storeURL = URL(string: verifyReceiptURL)!
            var storeRequest = URLRequest(url: storeURL)
            storeRequest.httpMethod = "POST"
            storeRequest.httpBody = requestData
            
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) in
                
                do {
                    let UserId = UserDefaults.standard.getUserID()
                    let apiCall = JsonApi()
                    let parameters = [
                        "user_id": UserId!,
                        "price": self!.totalAmount,
                        "status": "Confirm",
                        "plan_id": self!.planId,
                        "planname": self!.planName,
                        "pay_date": self!.currentDate,
                        "expiry_date":self!.validDate
                    ] as [String : Any]
                    print(parameters)
                    apiCall.callUrlSession(urlValue: "https://chawtechsolutions.co.in/dev/apex/api/userpayment.php", para: parameters as (AnyObject), isSuccess: true)
                    { [self] (result) -> Void in
                        print("service-",result)
                        var success = result["success"]
                        if result["success"] as! String == "true"{
                            
                            DispatchQueue.main.async {
                                self!.switchToTab(false)
                            }
                        }else{
                            DispatchQueue.main.async {
                                self!.switchToTab(true)
                            }
                        }
                    }

                } catch let parseError {
                    print(parseError)
                }
            })
            task.resume()
        } catch let parseError {
            print(parseError)
        }
    }
    
    func switchToTab(_ showSubscription:Bool) {
        let vc = TabBarViewController.instantiate(fromAppStoryboard: .main)
        
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            
            LTY_AppDelegate.window?.rootViewController = vc
        }
    }
    
    
    func daysCount(startDateTime: Date, endDateTime:Date) -> Int {
        let calendar = NSCalendar.current as NSCalendar
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: startDateTime)
        let date2 = calendar.startOfDay(for: endDateTime)
        
        let flags = NSCalendar.Unit.day
        let components = calendar.components(flags, from: date1, to: date2, options: [])
        
        return components.day!
    }
    
    func getExpirationDateFromResponse(_ jsonResponse: NSDictionary) -> Date? {
        
        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
            var planPrice = 0.0
            let lastReceipt = receiptInfo.lastObject as! NSDictionary
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            
            
            if let isTrialPeriod = lastReceipt["is_trial_period"] {
                print(isTrialPeriod)
                if isNewPurchase {
                    
                }
            }
            if let expiresDate = lastReceipt["expires_date"] as? String {
                return formatter.date(from: expiresDate)
            }
            
            return nil
        }
        else {
            return nil
        }
    }
    
    func getPurchaseDateFromResponse(_ jsonResponse: NSDictionary) -> Date? {
        
        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
            
            let lastReceipt = receiptInfo.lastObject as! NSDictionary
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            
            if let expiresDate = lastReceipt["purchase_date"] as? String {
                return formatter.date(from: expiresDate)
            }
            
            return nil
        }
        else {
            return nil
        }
    }
    

    
    
}

extension SKPaymentTransactionState {
    func status() -> String {
        switch self {
    
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
}
extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Okay", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

/*
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
             
             self.switchToTab(false)
             
         }
         
     }
 }
 */
