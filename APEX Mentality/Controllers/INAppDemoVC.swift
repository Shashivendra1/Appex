//
//  INAppDemoVC.swift
//  APEX Mentality
//
//  Created by CTS on 12/10/23.
//

import UIKit
import StoreKit

class INAppDemoVC: UIViewController ,SKPaymentTransactionObserver {
    
    @IBOutlet weak var purchaseLbl: UILabel!
    let productId = "com.test.monthly"
    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
       purchaseLbl.text = "purchase not complete yet"
}

    
    @IBAction func onClickPrchase(_ sender: Any) {
        if SKPaymentQueue.canMakePayments(){
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productId
            SKPaymentQueue.default().add(paymentRequest)
        }else{
            print("user unable to make payment")
         }
}
    
    
func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased{
             print("Transaction succes")
             purchaseLbl.text = "Purchase complete"
        }
            else if transaction.transactionState == .failed{
            print("Transaction failed")
            }
        }
    }

}
