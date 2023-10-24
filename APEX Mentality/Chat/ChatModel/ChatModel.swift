//
//  ChatModel.swift
//  APEX Mentality
//
//  Created by CTS on 09/08/23.
//

import Foundation

struct Message: Encodable {
    
    var content: String?
    var fromID: String?
    var timestamp: String?
    var isRead: Bool?
    var toID: String?
    var type: String?
    var queryId: String?
    var name : String?
    var image: String?
    
}

struct FirebaseUser {
    var uid, email, lastMessage, name, image, fcmKey: String?
    var timestamp, time: String?
}

