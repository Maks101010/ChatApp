//
//
// ChatAppApp.swift
// ChatApp
//
// Created by Shubh Magdani on 28/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import SwiftUI

@main
struct ChatAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var alert: AlertData = AlertData.empty
    @State private var showAlert: Bool = false
    @State private var showLoader: Bool = false
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { result in
                if let alert = result.object as? AlertData {
                    self.alert = alert
                    self.showAlert = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .showLoader)) { result in
                if let loaderData = result.object as? [Any], let showLoader = loaderData.first as? Bool {
                    print("showLoader - \(showLoader)")
                    self.showLoader = showLoader
                }
            }
            .activityIndicator(show: self.showLoader)

            .alert(isPresented: $showAlert) {
                     Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: alert.dismissButton)
            }
            
        }
    }
}
