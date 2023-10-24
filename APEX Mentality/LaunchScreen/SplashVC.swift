//
//  SplashVC.swift
//  APEX Mentality
//
//  Created by CTS on 03/08/23.
//

//import UIKit
//
//class SplashVC: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        isConnectedToInternet()
//        checkUserAlreadyLoggedIn()
//
//
//    }
//
//
//
//    func checkUserAlreadyLoggedIn(){
//          if UserDefaults.standard.isUserLoggedIn(){
//            DispatchQueue.main.async {
////                let homeVC = UIStoryboard.tabbarStoryboard().instantiateViewController(withIdentifier: "TabBarNavigation")
//
//
//    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//    self.navigationController?.pushViewController(vc, animated: true)
//
//
//    //            UIApplication.shared.windows.first?.rootViewController = homeVC
//    //            UIApplication.shared.windows.first?.makeKeyAndVisible()
//    //            self.present(homeVC, animated: true, completion: nil)
//
//                homeVC.modalPresentationStyle = .fullScreen
//                homeVC.modalTransitionStyle = .crossDissolve
//                self.present(homeVC, animated: true, completion: nil)
//            }
//            }else{
//            let loginVC = UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "LoginVCNavigation")
//            UIApplication.shared.windows.first?.rootViewController = loginVC
//            UIApplication.shared.windows.first?.makeKeyAndVisible()
//            self.present(loginVC, animated: true, completion: nil)
//        }
//        }
//
//
//
//
//
//
//
//    func isConnectedToInternet(){
//        NotificationCenter.default.addObserver(self, selector: #selector(LaunchScreenVC.networkStatusChanged(_:)), name: Notification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
//
//        Reach().monitorReachabilityChanges()
//    }
//
//
//    @objc func networkStatusChanged(_ notification: Notification) {
//        if let userInfo = notification.userInfo {
//            let status = userInfo["Status"] as! String
//            if status.range(of: "Online", options: .caseInsensitive) != nil{
//                hideOfflineMessage()
//            }else{
//                showOfflineMessage()
//            }
//        }
//    }
//
//
//
//}
