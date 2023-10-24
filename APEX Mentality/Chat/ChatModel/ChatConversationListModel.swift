//
//  ChatConversationListModel.swift
//  APEX Mentality
//
//  Created by CTS on 08/08/23.
//

import Foundation
struct ChatConversationListModel: Encodable {
    var fileName    : String
    var type   : String
    var content : String
    var timestamp  : String
    var queryId   : String
    var image   : String
    var toID  : String
    var fromID  : String
}

