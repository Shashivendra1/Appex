//
//  CommonFunctions.swift
//  APEX Mentality
//
//  Created by CTS on 20/06/23.
//

//import Foundation
//import UIKit
//let appDelegateInstance = UIApplication.shared.delegate as! AppDelegate
//
//func initialiseAppWithController(_ controller : UIViewController)
//{
//    let navigationController = UINavigationController(rootViewController: controller)
//    navigationController.isNavigationBarHidden = true
//    appDelegateInstance.window?.rootViewController = navigationController
//}
//
//func loadTabBar()->UITabBarController
//{
//    let tabBarController = UITabbarViewController()
//    let discover =  DiscoverViewController()
////    let events  =  EventsViewController()
////    let home =    HomeViewController()
////    let circles = CirclesViewController()
////    let courses = CoursesViewController()
//    
//    //set buttons images
//   let discover_deselect = UIImage(named : "discover_deselect")
//    let discover_select = UIImage(named : "Group")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//    let events_deselect = UIImage(named : "event_deselect")
//    let events_select = UIImage(named : "Group 34099")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
//    //    let home_deselect = UIImage(named: "homeSelect")
//    //    let home_select = UIImage(named: "homeSelect")
//    let circles_deselect = UIImage(named: "circle_deselect")
//    let circles_select = UIImage(named: "circle_select")
//    let courses_deselect = UIImage(named: "course_deselect")
//    let courses_select = UIImage(named: "course_select")
//    
//    // buttons for tabbar..
//    let discover_Button = UITabBarItem(title: "dmfkg", image: discover_deselect, selectedImage: discover_select)
//    let events_Button = UITabBarItem(title: "vbngm", image: events_deselect, selectedImage: events_select)
//    //let home_Button = UITabBarItem(title: "", image: home_deselect, selectedImage:home_select)
//    let circles_Button = UITabBarItem(title: "hello", image: circles_deselect, selectedImage: circles_select)
//    let courses_Button = UITabBarItem(title: "hiii", image: courses_deselect, selectedImage: courses_select)
//        discover.tabBarItem = discover_Button
////    events.tabBarItem = events_Button
//    //home.tabBarItem = home_Button
////    circles.tabBarItem = circles_Button
////    courses.tabBarItem = courses_Button
//    tabBarController.tabBar.backgroundColor = .clear //.white
//    tabBarController.tabBar.barTintColor    = #colorLiteral(red: 0.1490196078, green: 0.1215686275, blue: 0.1450980392, alpha: 1)
//    let screenSize: CGRect = tabBarController.tabBar.frame
//    let screenWidth = screenSize.width
//    var screenHeight = screenSize.height //CGFloat(60)
//    var isBottom: Bool {
//        if #available(iOS 13.0, *), UIApplication.shared.windows[0].safeAreaInsets.bottom > 0 {
//            return true
//        }
//            return false
//    }
//    if isBottom == true
//    {
//        screenHeight = screenHeight + 34
//    }
//    else
//    {
//        screenHeight = 60
//    }
//    
//    let bgView = UIImageView(image: UIImage(named: "tabbabrBackgroundImg"))
//    bgView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: screenWidth, height: screenHeight)
//    tabBarController.tabBar.addSubview(bgView)
//    let controllers = [discover]
//    tabBarController.setViewControllers(controllers , animated: true)
//    tabBarController.selectedIndex = 0
//    let navViewController = UINavigationController(rootViewController: tabBarController)
//    navViewController.navigationBar.isHidden = true
//    return tabBarController
//}
