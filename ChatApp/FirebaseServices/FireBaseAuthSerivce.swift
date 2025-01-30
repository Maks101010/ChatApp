//
//
// FireBaseAuthSerivce.swift
// ChatApp
//
// Created by Shubh Magdani on 29/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//

import Foundation
import FirebaseAuth
import SwiftUI
class FireBaseAuthService {
    static let shared : FireBaseAuthService = FireBaseAuthService()
    private var fireBaseUser : User?
    private init() {}
}

extension FireBaseAuthService {
    func registerUser (name : String , email : String , password : String , gender : String , phoneNumber : String , completion : @escaping (_ userModel : UserModel? ) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password){
            success ,
            error in
            guard error == nil
            else {
                self.handleError(error!)
                Indicator.hide()
                return
            }
            guard let user = success?.user
            else {
                Indicator.hide()
                print("No user data here....")
                return
            }
            
            
            let userDict : [String : Any] = UserModel.getUserInput(
                userId: user.uid,
                userName: name,
                gender: gender,
                email: email,
                phoneNumber: phoneNumber,
                password: password,
                createdDate: Date().formatted()
            )
            
            FireBaseDataStore.shared.setUserData(for: user.uid, userDict: userDict) {
                Indicator.hide()
                UserDefaults.standard.loginUser = UserModel(dictionary: userDict)
                UserDefaults.isLoggedIn = true
                completion(UserModel(dictionary: userDict))
            }
            
            
        }
    }
}

extension FireBaseAuthService {
    func signIn(with email : String , and password : String, completion : @escaping ((UserModel?) -> ())){
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil
            else {
                Indicator.hide()
                self.handleError(error!)
                return
            }
            guard let user = result?.user
            else {
                Indicator.hide()
                return
            }
            
            FireBaseDataStore.shared.getUserData(for: user.uid){userModel in
                Indicator.hide()
                UserDefaults.standard.loginUser = userModel
                UserDefaults.isLoggedIn = true
                completion(userModel)
            }
        }
        
    }
}


extension FireBaseAuthService {
    func logoutUser(completion: (() -> ())) {
        do {
            try Auth.auth().signOut()
            
            UserDefaults.standard.loginUser = nil
            UserDefaults.isLoggedIn = false
            completion()
        } catch {
            Alert.show(message: error.localizedDescription)
        }
    }
}


extension FireBaseAuthService {
    func handleError(_ error: Error) {
        print(error.localizedDescription)
        Alert.show(message: error.localizedDescription)
    }
}

