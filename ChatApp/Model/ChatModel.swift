//
//
// ChatModel.swift
// ChatApp
//
// Created by Shubh Magdani on 29/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import Foundation

struct ChatModel : Codable , Hashable , Identifiable {
    var id = UUID()
    var messageId : String?
    var messageBody : String?
    var senderUserName : String?
    var isDeleted : String?
    var createDate : String?
    var createDateTimeStamp : Int?
    var deletedUserNames : String?
    enum CodingKeys : CodingKey {
        case messageId , messageBody , senderUserName , isDeleted , createDate , createDateTimeStamp , deletedUserNames
    }
    init(
        messageId: String? ,
        messageBody: String? = nil,
        senderUserName: String? = nil,
        isDeleted: String? = nil,
        createDate: String? = nil,
        createDateTimeStamp: Int? = nil,
        deletedUserNames: String? = nil
    ) {
        self.messageId = messageId
        self.messageBody = messageBody
        self.senderUserName = senderUserName
        self.isDeleted = isDeleted
        self.createDate = createDate
        self.createDateTimeStamp = createDateTimeStamp
        self.deletedUserNames = deletedUserNames
    }
    init?(dictionary : [String : Any]){
        self.messageId = dictionary["messageId"] as? String ?? ""
        self.messageBody = dictionary["messageBody"] as? String ?? ""
        self.senderUserName = dictionary["senderUserName"] as? String ?? ""
        self.isDeleted = dictionary["isDeleted"] as? String ?? ""
        self.createDate = dictionary["createDate"] as? String ?? ""
        self.createDateTimeStamp = dictionary["createDateTimeStamp"] as? Int ?? nil
        self.deletedUserNames = dictionary["deletedUserNames"] as? String ?? ""
    }
}


extension ChatModel {
    static func ChatsData (
        messageId: String? ,
        messageBody: String? = nil,
        senderUserName: String? = nil,
        isDeleted: String? = nil,
        createDate: String? = nil,
        createDateTimeStamp: Int? = nil,
        deletedUserNames: String? = nil
    ) -> [String : Any] {
        var dict : [String : Any] = [:]
        dict["messageId"] = messageId ?? ""
        dict["messageBody"] = messageBody ?? ""
        dict["senderUserName"] = senderUserName ?? ""
        dict["isDeleted"] = isDeleted ?? ""
        dict["createDate"] = createDate ?? ""
        dict["createDateTimeStamp"] = createDateTimeStamp ?? nil
        dict["deletedUserNames"] = deletedUserNames ?? nil
        return dict
    }
}
