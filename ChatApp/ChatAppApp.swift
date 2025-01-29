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
            ZStack(alignment: .topTrailing) {
                AuthView()
                
            }
            .activityIndicator(show: self.showLoader)
            .onReceive(NotificationCenter.default.publisher(for: .showLoader)) { result in
                if let loaderData = result.object as? [Any], let showLoader = loaderData.first as? Bool {
                    self.showLoader = showLoader
                }
            }
            .alert(isPresented: $showAlert) {
                if self.alert.isLogOut == true {
                    return Alert(
                        title: Text(self.alert.title), message: Text(self.alert.message),
                        dismissButton: .default(Text("OK"), action: {
                            DispatchQueue.main.async {
                                
                            }
                        })
                    )
                } else
                {
                    return Alert(title: Text(alert.title), message: Text(alert.message), dismissButton: alert.dismissButton)
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .showAlert)) { result in
                if let alert = result.object as? AlertData {
                    self.alert = alert
                    self.showAlert = true
                }
            }
            
        }
    }
}
