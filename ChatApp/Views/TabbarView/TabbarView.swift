//
//  TabbarView.swift
//  ChatApp
//
//  Created by differenz48 on 31/01/25.
//

import SwiftUI

struct TabbarView: View {
    @ObservedObject var viewModel : ChatAppModel = .shared
    ///`Declarations`
    @State var selectedTab: Int = 0
    @State var isNewRoom: Bool = false
    @State var email : String = ""
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                DashBoardView(chatList: $viewModel.chatList)
                    .tabItem {
                        Image(systemName: "message")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 1 ? Color.AppBrownColor : Color.black)
                            .frame(width: 20, height: 20)
                        CommonText(title: "Chats", fontSize: 12,foregroundColor: selectedTab == 0 ? Color.AppBrownColor : Color.black)
                    }
                    .tag(0)
                
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(selectedTab == 1 ? Color.AppBrownColor : Color.black)
                            .frame(width: 20, height: 20)
                        CommonText(title: "Settings", fontSize: 12, foregroundColor: selectedTab == 1 ? Color.AppBrownColor : Color.black)
                    }
                    .tag(1)
            }
        }
        .onAppear{
            Indicator.show()
            FireBaseDataStore.shared.getChatListData(loginUserId: UserDefaults.standard.loginUser?.userId ?? ""){chatList in
                viewModel.chatList = chatList
            }
            setTabItemColor()
        }
        .sheet(isPresented: $isNewRoom){
            NavigationStack {
                ScrollView {
                    VStack {
                        TextFieldView(placeholder: "Email", text: $email)
                        Spacer(minLength: 15)
                        ButtonView(title: "Verify", action: {
                            isNewRoom = false
                            
                            if UserDefaults.standard.loginUser?.email == email {
                                
                                Alert.show(message: "Can't put this email")
                                email = ""
                            }
                            else {
                                Indicator.show()
                                FireBaseDataStore.shared.getUserIDByEmail(email: email){ userId in
                                    if let userId = userId {
                                       
                                        FireBaseDataStore.shared.isRoomIDUnique(user1ID: UserDefaults.standard.loginUser?.userId ?? "", user2ID: userId){ isUnique in
                                            if isUnique {
                                                let roomId = "\( UserDefaults.standard.loginUser?.userId ?? "")_\(userId)"
                                                FireBaseDataStore.shared.setRoomIDs(roomId: roomId){
                                                    
                                                }
                                            }
                                            else {
                                                Alert.show(message:"RoomId already exist.")
                                            }
                                        }
                                    }
                                    else {
                                        email = ""
                                        Alert.show(message: "This email is not registered yet")
                                    }
                                }
                                
                                
                            }
                        })
                            }
                    .padding()
                }
                .navigationTitle(Text("New Conversation"))
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            email = ""
                            isNewRoom = false
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30,height: 30)
                                .foregroundStyle(Color.AppBrownColor)
                        }
                    }
                }
            }
            .presentationDetents([.fraction(0.35)])
        }
        .navigationTitle(Text(selectedTab == 1 ? "Settings" : "Chats"))
        .navigationBarBackButtonHidden(true)
        .toolbar{
            if selectedTab == 0 {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isNewRoom = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .tint(Color.AppBrownColor)
                    }
                }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button(action : {
                                    FireBaseAuthService.shared.logoutUser {
                                        viewModel.isDashBoardShowing = false
                                    }
                                }){
                                    CommonText(title: "Logout")
                                }
                            }

            }
        }
    }
    
    
}

#Preview {
    TabbarView()
}

extension TabbarView {
    
    func setTabItemColor() {
        let appearance = UITabBarAppearance()
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "AppBrownColor")
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "AppBrownColor") ?? .red]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
