//
//  AppDelegate.swift
//  APEX Mentality
//  Created by CTS on 14/06/23.
//
import UIKit
import Firebase
import Messages
import IQKeyboardManager
import Glassfy

let gcmMessageIdKey = "gcm.message_id"
var selectedSegmentIndex = 0
@main
class AppDelegate: UIResponder, UIApplicationDelegate , SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    }
    
    var window:UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
       // Thread.sleep(forTimeInterval: 2)
//    Glassfy.initialize(apiKey: "121d754d4cf34b8e8613082cb038606c")
        IAPService.shared.getProducts()
     

        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )
        application.registerForRemoteNotifications()

        userLoginType()
        IQKeyboardManager.shared().isEnabled = true
       
//        IQKeyboardManager.shared().isEnableAutoToolbar = false
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false

           return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
}
    
    func switchToTab(){
        let vc = TabBarViewController.instantiate(fromAppStoryboard: .main)
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            LTY_AppDelegate.window?.rootViewController = vc
        }
    }
    
    

    
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo
      Messaging.messaging().appDidReceiveMessage(userInfo)

      // Change this to your preferred presentation option
      completionHandler([[.alert, .sound]])
    }

 func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo
        if let messageID  = userInfo[gcmMessageIdKey]{
            print("Message ID: \(messageID)")
        }
              print(userInfo)
            Messaging.messaging().appDidReceiveMessage(userInfo)
             completionHandler()
    }

    
    func application(_ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
       fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      Messaging.messaging().appDidReceiveMessage(userInfo)
      completionHandler(.noData)
    }
}


extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
//       UserDefaults.standard.getFcmToken()
        UserDefaults.standard.saveFcmToken(fcmKey:fcmToken ?? "")
//       UserDefaults.standard.getFcmToken()
        
//      UserDefaults.standard.set(fcmToken, forKey: "fcm_key")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
    }
    
    func switchToWelcomeVC() {
        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  userStoryboard.instantiateViewController(withIdentifier: "WelcomeLoginScreen") as! WelcomeLoginScreen
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
    }
    
    func switchToLoginVC() {
        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  userStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
    }
    
 func switchToHomeVC() {
        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  userStoryboard.instantiateViewController(withIdentifier: "coachMessageVC") as! coachMessageVC
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
    }
    

    func userLoginType(){
     
        let userType = UserDefaults.standard.getUserRole()
        print(userType)
        var showSubscription = UserDefaults.standard.value(forKey:"showSubscription")
        
        if showSubscription == nil {
            UserDefaults.standard.set("yes", forKey:"showSubscription")
            showSubscription = UserDefaults.standard.value(forKey:"showSubscription")

        }
        
        if userType == "client" {
            
//            IAPService.shared.getProducts()
            
            if showSubscription as! String == "no"{
                self.switchToTab()
            }else{
                self.switchToTab()
            }
        }else if userType == nil {
            self.switchToWelcomeVC()
            
        } else if userType == "1" {
            self.switchToLoginVC()
            
        } else{
            self.switchToHomeVC()
        }
    }
    
    
}
