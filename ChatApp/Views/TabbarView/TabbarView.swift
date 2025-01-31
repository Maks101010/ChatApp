//
//  TabbarView.swift
//  ChatApp
//
//  Created by differenz48 on 31/01/25.
//

import SwiftUI

struct TabbarView: View {
    
    ///`Declarations`
    @State var selectedTab: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                DashBoardView()
                    .tabItem {
                        Image(systemName: "message")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 2 ? Color.AppBrownColor : Color.black)
                            .frame(width: 20, height: 20)
                        CommonText(title: "Chats", fontSize: 12,foregroundColor: selectedTab == 0 ? Color.AppBrownColor : Color.black)
                    }
                    .tag(0)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 2 ? Color.AppBrownColor : Color.black)
                            .frame(width: 20, height: 20)
                        CommonText(title: "Settings", fontSize: 12, foregroundColor: selectedTab == 2 ? Color.AppBrownColor : Color.black)
                    }
                    .tag(2)
            }
        }
        .navigationTitle(Text("Chats"))
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30,height: 30)
                }
            }
        }
    }
}

#Preview {
    TabbarView()
}
