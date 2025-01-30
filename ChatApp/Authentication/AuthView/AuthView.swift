//
//  AuthView.swift
//  ChatApp
//
//  Created by differenz48 on 29/01/25.
//

import SwiftUI

struct AuthView: View {
    
    ///`Declarations
    @StateObject var authVM: AuthViewModel = AuthViewModel()
    @ObservedObject var viewModel: ChatAppModel = .shared
    @State var selectedIndex: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.AppBrownColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                CommonText(title: "Hey!",fontSize: 30)
                    .padding(.horizontal,15)
                
                CommonText(title: selectedIndex != 0 ? "Join Now" : "Welcome Back",fontSize: 30)
                    .padding(.horizontal,15)
                
                VStack(spacing: 20) {
                    
                    SegmentedPicker(selectedIndex: $selectedIndex)
                        .padding(15)
                    ScrollView(showsIndicators: false) {
                        if selectedIndex == 1 {
                            UserRegister()
                                .padding(.vertical)
                        }
                        else {
                            UserLogin()
                                .padding(.vertical)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height / 1.5)
                .background(Color.white)
                .cornerRadius(30)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear{
            if UserDefaults.isLoggedIn == true {
                self.viewModel.isDashBoardShowing = true
            }
            
#if DEBUG
            self.authVM.txtLoginEmail = "testUser@gmail.com"
            self.authVM.txtLoginPassword = "12345678"
            self.authVM.txtRegisterEmail = "testUser@gmail.com"
            self.authVM.txtPhoneNumber = "1234567890"
            self.authVM.txtRegisterPassword = "12345678"
            self.authVM.txtConfirmPassword = "12345678"
            self.authVM.txtGender = "Male"
            self.authVM.txtUserName = "testuser"
#endif
        }
        .navigationDestination(isPresented: $viewModel.isDashBoardShowing){
            DashBoardView()
        }
    }
}

#Preview {
    AuthView()
}

extension AuthView {
    
    func UserRegister() -> some View {
        VStack(spacing: 20){
            TextFieldView(placeholder: "Name", text: $authVM.txtUserName)
                .onChange(of: authVM.txtUserName){
                    authVM.txtUserName = authVM.txtUserName.trimWhiteSpace.lowercased()
                }
            TextFieldView(placeholder: "Email Address", text: $authVM.txtRegisterEmail)
            
            GenderPicker(placeholder: "Gender", text: $authVM.txtGender)
            
            TextFieldView(placeholder: "Phone Number", text: $authVM.txtPhoneNumber)
            
            SecureFieldView(placeholder: "Password", text: $authVM.txtRegisterPassword)
            SecureFieldView(placeholder: "Confirm Password", text: $authVM.txtConfirmPassword)
            
            ButtonView(title: "Sign Up") {
                self.authVM.clickOnRegisterBtn {userModel in
                    if userModel != nil {
                        viewModel.isDashBoardShowing = true
                    }
                    else {
                        Alert.show(title: "SignUp Failed !!!!!")
                    }
                }
            }
        }
        .padding(15)
    }
    
    func UserLogin() -> some View {
        VStack(spacing: 20) {
            TextFieldView(placeholder: "Email Address", text: $authVM.txtLoginEmail)
            
            SecureFieldView(placeholder: "Password", text: $authVM.txtLoginPassword)
            
            ButtonView(title: "Login") {
                self.authVM.clickOnLoginBtn { userModel in
                    if userModel != nil {
                        viewModel.isDashBoardShowing = true
                    }
                    else {
                        Indicator.hide()
                        Alert.show(title: "Login Failed !!!!!")
                    }
                }
            }
            .padding(.top,15)
        }
        .padding(15)
    }
}
