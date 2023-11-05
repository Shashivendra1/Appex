//
//  Apis.swift
//  APEX Mentality
//
//  Created by CTS on 17/07/23.
//

import Foundation
import UIKit
let LTY_AppDelegate = UIApplication.shared.delegate as! AppDelegate


struct APIs {
    static let BASE_URL = "https://chawtechsolutions.co.in/dev/apex/api/"
    static let USER_REGISTRATION = BASE_URL + "client_register.php"
    static let CLIENT_LOGIN = BASE_URL + "login.php"
    static let GET_PROFILE = BASE_URL + "get_profile.php"
    static let GET_COACHE_LIST = BASE_URL + "get_coache_list.php"
    static let FORGOT_PASSWORD = BASE_URL + "forgot_password.php"
    static let PROFILE_IMAGE = BASE_URL + "profile_image.php"
    static let EDIT_PROFILE = BASE_URL + "edit_profile.php"
    static let CHANGE_PASSWORD = BASE_URL + "change_password.php"
    static let SEND_REQUEST = BASE_URL + "requestsend.php"
    static let NEED_HELP = BASE_URL + "needhelp.php"
    static let PAYMENT_DETAILS = BASE_URL + "userpayment.php"
    static let USER_COACH_ASSIGN = BASE_URL + "usercoache.php "
    static let GET_ALL_USER_FOR_ADMINCHAT = BASE_URL + "getallusers.php"
    static let ALL_NOTIFICATION_COACH_BY_CLIENTREQUEST = BASE_URL + "coachnotifications.php"
    static let CLIENT_REQUEST_ACCEPT_BY_COACH = BASE_URL + "statusaccepted.php"
    static let CLIENT_REQUEST_REJECTED_BY_COACH = BASE_URL + "statusrejected.php"
    static let CLIENT_REQUESTED_APPROVED_STATUSLIST = BASE_URL + "client_approved_status.php"
    static let CLIENT_REQUEST_PENDIN_STATUS_LIST = BASE_URL + "client_pending_status.php"
    static let CLIENT_REQUESTED_REJECTED_STATUSLIST = BASE_URL + "client_rejected_status.php"
    static let PAYMENT_SUBSCRIPTION = BASE_URL + "payment_subscriptions.php"

}






