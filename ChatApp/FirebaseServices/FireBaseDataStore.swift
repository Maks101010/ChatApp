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
                Indicator.hide()
                Alert.show(message : "\(error.localizedDescription)")
                print("error in generating the room id :   \(error.localizedDescription)")
            }
            else {
                Indicator.hide()
                completion()
            }
        }
    }
}

extension FireBaseDataStore {
    func isRoomIDUnique(user1ID: String, user2ID: String, completion: @escaping (Bool) -> ()) {
        let roomId1 = "\(user1ID)_\(user2ID)"
        let roomId2 = "\(user2ID)_\(user1ID)" // Reverse order

        let chatRef1 = self.db.getCollection(.chats).document(roomId1)
        let chatRef2 = self.db.getCollection(.chats).document(roomId2)

        chatRef1.getDocument { (document1, error1) in
            if let error1 = error1 {
                print("Error checking room ID \(roomId1): \(error1.localizedDescription)")
                completion(false)
                return
            }

            if let document1 = document1, document1.exists {
                print("Room ID \(roomId1) already exists")
                completion(false)
                return
            }

            chatRef2.getDocument { (document2, error2) in
                if let error2 = error2 {
                    print("Error checking room ID \(roomId2): \(error2.localizedDescription)")
                    completion(false)
                    return
                }

                if let document2 = document2, document2.exists {
                    print("Room ID \(roomId2) already exists")
                    completion(false)
                } else {
                    print("Room ID is unique")
                    completion(true)
                }
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


extension FireBaseDataStore {
    func getUserIDByEmail(email: String, completion: @escaping (String?) -> Void) {
        self.db.getCollection(.users)
            .whereField("email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    Indicator.hide()
                    Alert.show(message : "\(error.localizedDescription)")
                    completion(nil) // Return nil if there's an error
                    return
                }

                if let document = snapshot?.documents.first {
                    let userId = document.documentID
                    Indicator.hide()
                    completion(userId) // Return user ID if found
                }
                else {
                    Indicator.hide()
                    completion(nil) // No email found
                }
            }
    }
}


extension FireBaseDataStore {
    func getChatListData(loginUserId: String, completion: @escaping ([ChatListModel]) -> ()) {
        self.db.getCollection(.chats).addSnapshotListener { (snapshot, error) in
            if let error = error {
                Indicator.hide()
                Alert.show(message: "Error ")
                print("Error observing chat rooms: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let documents = snapshot?.documents else {
                Indicator.hide()
                Alert.show(message: "Error ")
                completion([])
                return
            }

            var chatList: [ChatListModel] = []
            let dispatchGroup = DispatchGroup()
            let chatListQueue = DispatchQueue(label: "chatlist") // Protects shared resource

            for document in documents {
                let roomId = document.documentID
                let userIds = roomId.split(separator: "_").map { String($0) }

                // Find the other user's ID
                guard userIds.contains(loginUserId), let otherUserID = userIds.first(where: { $0 != loginUserId }) else {
                    continue
                }

                dispatchGroup.enter()

                // Listen for real-time message changes
                self.db.getCollection(.chats).document(roomId).collection("messages")
                    .order(by: "timestamp", descending: true)
                    .limit(to: 1)
                    .addSnapshotListener { (messageSnapshot, messageError) in
                        var lastMessage = "No messages"
                        var timestamp: Int = 0

                        if let lastMessageDoc = messageSnapshot?.documents.first, messageError == nil {
                            lastMessage = lastMessageDoc["messageBody"] as? String ?? "No messages"
                            timestamp = lastMessageDoc["timestamp"] as? Int ?? 0
                        }

                        // Listen for real-time user name changes
                        self.db.getCollection(.users).document(otherUserID).addSnapshotListener { (userSnapshot, userError) in
                            defer { dispatchGroup.leave() } // Ensure it's called to prevent deadlocks

                            let otherUserName = userSnapshot?.data()?["userName"] as? String ?? "Unknown User"

                            let chatItem = ChatListModel(
                                userName: otherUserName,
                                lastMessage: lastMessage,
                                timeStamp: timestamp
                            )

                            // Synchronize chatList update
                            chatListQueue.sync {
                                chatList.append(chatItem)
                            }
                        }
                    }
            }

            dispatchGroup.notify(queue: .main) {
                Indicator.hide()
                completion(chatList.sorted { ($0.timeStamp ?? 0) > ($1.timeStamp ?? 0) }) // Sort safely
            }
        }
    }
}


extension Firestore {
    func getCollection(_ collectionPath: FBDataStoreCollection) -> CollectionReference {
        self.collection(collectionPath.rawValue)
    }
}




