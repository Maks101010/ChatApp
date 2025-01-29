//
//
// ChatAppModel.swift
// ChatApp
//
// Created by Shubh Magdani on 29/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import Foundation
class ChatAppModel: ObservableObject {
    init () {}
    static var shared: ChatAppModel = ChatAppModel()
    @Published var themeColor = UserDefaults.themeColor
}
