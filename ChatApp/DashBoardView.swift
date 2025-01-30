//
//
// DashBoardView.swift
// ChatApp
//
// Created by Shubh Magdani on 30/01/25
// Copyright © 2025 Differenz System Pvt. Ltd. All rights reserved.
//


import SwiftUI
struct DashBoardView : View {
    @ObservedObject var viewModel : ChatAppModel = .shared
    var body: some View {
        
        
        
        
        
        
        
        Button(action : {
            FireBaseAuthService.shared.logoutUser {
                viewModel.isDashBoardShowing = false
            }
        }){
            Text("Logout")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashBoardView(viewModel: ChatAppModel())
}
