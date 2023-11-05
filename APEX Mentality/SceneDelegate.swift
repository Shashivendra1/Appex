//
//  SceneDelegate.swift
//  APEX Mentality
//
//  Created by CTS on 14/06/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        userLoginType()
//        var userStatus = UserDefaults.standard.value(forKey:"LOGGED_IN")
//        if userStatus == nil || userStatus as! String == "false" {
//            UserDefaults.standard.set("false", forKey: "LOGGED_IN")
//            switchToLoginVC()
//        }else{
//            UserDefaults.standard.set("true", forKey: "LOGGED_IN")
//            switchToHomeVC()
//        }
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    func switchToHomeVC() {
        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc =  userStoryboard.instantiateViewController(withIdentifier: "coachMessageVC") as! coachMessageVC
        let navVC = SwipeableNavigationController(rootViewController: vc)
        navVC.setNavigationBarHidden(true, animated: false)
        self.window?.rootViewController = navVC
        
        
        //        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc =  userStoryboard.instantiateViewController(withIdentifier: "DashBoardVC") as! DashBoardVC
        //           if #available(iOS 13.0, *) {
        //               UIApplication.shared.windows.first?.rootViewController = vc
        //               UIApplication.shared.windows.first?.makeKeyAndVisible()
        //           } else {
        //
        //               self.window?.rootViewController = vc
        //           }
       
    }
    func switchToWelcomeVC() {
        let userStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = userStoryboard.instantiateViewController(withIdentifier: "WelcomeLoginScreen") as! WelcomeLoginScreen

//        let vc =  userStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
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
    
    func switchToTab() {
        let vc = TabBarViewController.instantiate(fromAppStoryboard: .main)
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        } else {
            LTY_AppDelegate.window?.rootViewController = vc
        }
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
            if showSubscription as! String == "no"{
                self.switchToTab()
            }else{
                self.switchToTab()
            }
        }
        else if userType == nil {
            self.switchToWelcomeVC()
            
        } else if userType == "1" {
            self.switchToLoginVC()
            
        } else{
            self.switchToHomeVC()
            
        }
    }

    
    


}

