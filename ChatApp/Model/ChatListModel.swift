//
//
// ChatListModel.swift
// ChatApp
//
// Created by Shubh Magdani on 31/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import Foundation

struct ChatListModel: Codable, Hashable, Identifiable {
    var id = UUID()
    var userName: String?
    var lastMessage: String?
    var timeStamp: Int? // Store timestamp as Int

    init(userName: String? = nil, lastMessage: String? = nil, timeStamp: Int? = nil) {
        self.userName = userName
        self.lastMessage = lastMessage
        self.timeStamp = timeStamp
    }

    // Convert Int timestamp to readable date format
    var formattedTime: String {
        guard let timeStamp = timeStamp else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a" // Example: "Jan 31, 10:30 AM"
        return dateFormatter.string(from: date)
    }
}
