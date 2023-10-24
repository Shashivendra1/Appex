//
//  GlobalMethods.swift
//  APEX Mentality
//
//  Created by CTS on 14/07/23.
//

import Foundation
import UIKit
import SVProgressHUD
import MBProgressHUD
func showLoading(){
    SVProgressHUD.show()
    SVProgressHUD.setDefaultMaskType(.none)
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(.clear)
//    SVProgressHUD.setForegroundColor(Colors.appThemeColor)
}
func showLoadingWithBackground(){
    SVProgressHUD.show()
    SVProgressHUD.setDefaultStyle(.dark)
    SVProgressHUD.setBackgroundColor(.clear)
    SVProgressHUD.setDefaultMaskType(.black)
//    SVProgressHUD.setForegroundColor(Colors.appThemeColor)
}
func hideLoading(){
  SVProgressHUD.dismiss()
}
