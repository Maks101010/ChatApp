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
    @Binding var chatList : [ChatListModel]
    
    var body: some View {
        VStack(spacing: 5) {
//            SearchBarView(searchText: viewModel.searchText)
            theList()
            
           

        }
        .padding(.horizontal,15)
//        .navigationBarBackButtonHidden(true)
        

    }
}

#Preview {
    DashBoardView(chatList:.constant( []))
}

extension DashBoardView {
    
    func theList() -> some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 10) {
                    ForEach(chatList, id: \.id) { chat in
                        VStack {
                            HStack(alignment: .top) {
                                // Profile Image (If needed, replace with actual user image)
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                    .foregroundColor(.gray)
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    HStack {
                                        // Display User Name
                                        CommonText(title: chat.userName ?? "Unknown", fontSize: 18, weight: .semibold)
                                        
                                        Spacer()
                                        
                                        // Display TimeStamp
                                        CommonText(title: chat.formattedTime ?? "", fontSize: 14, weight: .regular)
                                            .foregroundColor(.gray)
                                    }
                                    
                                    HStack {
                                        // Display Last Message
                                        CommonText(title: chat.lastMessage ?? "No messages yet", fontSize: 15)
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
