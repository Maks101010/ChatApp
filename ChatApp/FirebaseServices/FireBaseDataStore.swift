//
//
// FireBaseDataStore.swift
// ChatApp
//
// Created by Shubh Magdani on 29/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import Foundation
import SwiftUI
import FirebaseFirestore



enum FBDataStoreCollection : String {
    case users = "Users"
}


class FireBaseDataStore {
    static let shared : FireBaseDataStore = FireBaseDataStore()
    private init () {}
    let db : Firestore = Firestore.firestore()
}


extension FireBaseDataStore {
    func setUserData (for userID : String, userDict : [String : Any] , completion : @escaping (()->())) {
        self.db.getCollection(.users).document(userID).setData(userDict) { error in
            if let error = error as? NSError {
                
                print("error getting for  set the user data with documentId: \(userID), error: \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }
}

extension FireBaseDataStore {
    func getUserData(for userID: String , completion :@escaping ((UserModel?) -> ())){
        self.db.getCollection(.users).document(userID).getDocument{ FBData , error in
            if let error = error as? NSError {
                print("error getting data from UserDocument with id \(userID) , error \(error.localizedDescription) ")
                Indicator.hide()
                completion(nil)
            }
            else {
                guard let document = FBData else {return}
                do {
                    let messageModel = try document.data(as: UserModel.self)
                    Indicator.hide()
                    completion(messageModel)
                }
                catch let error {
                    print("Error in read(from:ofType:) description= \(error.localizedDescription)")
                }
            }
            
        }
    }
}


extension Firestore {
    func getCollection(_ collectionPath: FBDataStoreCollection) -> CollectionReference {
        self.collection(collectionPath.rawValue)
    }
}
