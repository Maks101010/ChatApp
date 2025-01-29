//
//
// Constants.swift
// FireBaseIntegration
//
// Created by Shubh Magdani on 31/12/24
// Copyright © 2024 Differenz System Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension Notification.Name {
    static let showAlert                    = Notification.Name("showAlert")
    static let showLoader                   = Notification.Name("showLoader")
}

enum Gender {
    static let kMale                                    = "Male"
    static let kFemale                                  = "Female"
    static let kOther                                   = "Other"
}

struct Constants {
    
    static let predefinedColors: [Color] = [
        Color.cyan, Color.yellow, Color.blue, Color.purple, Color.brown,
        Color.orange, Color.gray, Color.indigo, Color.mint, Color.pink, Color.teal
        ]
}

// MARK: - Color Extensions
extension Color {
    
    public static var AppBrownColor: Color {
        return Color(UIColor(named: "AppBrownColor") ?? .red)
    }
}

// MARK: - iPhone Screensize
struct ScreenSize {
    static let SCREEN_WIDTH             = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT            = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH        = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH        = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

