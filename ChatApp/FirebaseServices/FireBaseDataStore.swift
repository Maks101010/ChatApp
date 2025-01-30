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
    case chats = "Chats"
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
                Alert.show(message: "\(error.localizedDescription)")
                return
            }
            else {
                guard let document = FBData else {return}
                do {
                    let messageModel = try document.data(as: UserModel.self)
                    Indicator.hide()
                    completion(messageModel)
                }
                catch let error {
                    print("error getting data from UserDocument with id \(userID) , error \(error.localizedDescription) ")
                    Indicator.hide()
                    Alert.show(message: "\(error.localizedDescription)")
                    return
                }
            }
            
        }
    }
}

extension FireBaseDataStore {
    func isUserIDUnique(userID: String, completion: @escaping (Bool) -> Void) {
        self.db.getCollection(.users).document(userID).getDocument { document, error in
            if let error = error {
                print("Error checking user ID uniqueness: \(error.localizedDescription)")
                completion(false) // Assume not unique if there's an error
                return
            }
            
            if let document = document, document.exists {
                completion(false) // User ID already exists
            } else {
                completion(true) // User ID is unique
            }
        }
    }
}





extension FireBaseDataStore {
    func setChatData(roomId : String ,chatData : [String : Any] , completion:@escaping (() -> ())){
        self.db.getCollection(.chats).document(roomId).setData(chatData) { error in
            if let error = error {
                print("error for seting the chatData with roomId \(roomId) , error : \(error.localizedDescription)")
            }
            else {
                completion()
            }
        }
    }
}

extension FireBaseDataStore {
    func setRoomIDs(roomId : String ,completion:@escaping (()->())){
       self.db.getCollection(.chats).document(roomId).setData(["messages": []]) { error in
            if let error = error {
                print("error in generating the room id :   \(error.localizedDescription)")
            }
            else {
                completion()
            }
        }
    }
}


extension FireBaseDataStore {
    func isRoomIDUnique(roomId: String, completion: @escaping (Bool) -> ()) {
        let chatRef = self.db.getCollection(.chats).document(roomId)

        chatRef.getDocument { (document, error) in
            if let error = error {
                print("Error checking room ID \(roomId): \(error.localizedDescription)")
                completion(false) // Assume room exists in case of an error
                return
            }
            
            if let document = document, document.exists {
                // Room ID already exists
                print("Room ID \(roomId) already exists")
                completion(false)
            } else {
                // Room ID is unique
                print("Room ID \(roomId) is unique")
                completion(true)
            }
        }
    }
}


extension FireBaseDataStore {
    func addMessageToRoom(roomId: String, message: [String: Any], completion: @escaping (() -> ())) {
        let chatRef = self.db.getCollection(.chats).document(roomId)

        chatRef.updateData([
            "messages": FieldValue.arrayUnion([message]) // Append message without overwriting
        ]) { error in
            if let error = error {
                print("Error adding message to room \(roomId): \(error.localizedDescription)")
            } else {
                completion()
            }
        }
    }
}






extension Firestore {
    func getCollection(_ collectionPath: FBDataStoreCollection) -> CollectionReference {
        self.collection(collectionPath.rawValue)
    }
}
