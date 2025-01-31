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
    
    ///`Declarations`
    @ObservedObject var viewModel : ChatAppModel = .shared
    
    var body: some View {
        VStack(spacing: 5) {
            SearchBarView(searchText: $viewModel.searchText)
            chatList()
            
            //            ToolbarItem(placement: .topBarTrailing) {
            //                Button(action : {
            //                    FireBaseAuthService.shared.logoutUser {
            //                        viewModel.isDashBoardShowing = false
            //                    }
            //                }){
            //                    CommonText(title: "Logout")
            //                }
            //            }

        }
        .padding(.horizontal,15)
//        .navigationBarBackButtonHidden(true)
        

    }
}

#Preview {
    DashBoardView(viewModel: ChatAppModel())
}

extension DashBoardView {
    
    func chatList() -> some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(0..<5, id: \.self) { index in
                        VStack {
                            HStack(alignment: .top) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    
                                    HStack {
                                        CommonText(title: "Username", fontSize: 18, weight: .semibold)
                                        
                                        Spacer()
                                        
                                        CommonText(title: "Today", fontSize: 14, weight: .regular)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        CommonText(title: "Message", fontSize: 15)
                                            .lineLimit(2)
                                            .foregroundColor(.gray)
                                    }
                                }
                            }
                            .padding(.vertical, 10)
                            
                            Divider()
                                .background(Color.gray.opacity(0.3))
                        }
                    }
                }
            }
            .background(Color.white)
            .cornerRadius(10)
        }
    }
}
