//
//
// UserModel.swift
// ChatApp
//
// Created by Shubh Magdani on 29/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import Foundation

struct UserModel: Codable {
    
    var userName : String?
    var gender : String?
    var email : String?
    var phoneNumber : String?
    var password : String?
    var createdDate : String?
   
    
    enum CodingKeys: CodingKey {
        case userName, gender, email, phoneNumber, password,createdDate
    }
    init?(dictionary : [String : Any]) {
        self.userName = dictionary["userName"] as? String ?? ""
        self.gender = dictionary["gender"] as? String ?? ""
        self.password = dictionary["password"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        self.createdDate = dictionary["createdDate"] as? String ?? ""
    }
}

/** Converts model into dictionary **/
extension UserModel {
    static func getUserInput(
        userName : String? = nil,
        gender : String? = nil,
        email : String? = nil,
        phoneNumber : String? = nil,
        password : String? = nil,
        createdDate : String? = nil
    ) -> [String:Any] {
        var dict: [String:Any] = [:]
        dict["userName"] = userName ?? ""
        dict["gender"] = gender ?? ""
        dict["email"] = email ?? ""
        dict["phoneNumber"] = phoneNumber ?? ""
        dict["password"] = password ?? ""
        dict["createDate"] = createdDate ?? ""
        return dict
    }
}
