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
                        }
                        else {
                            UserLogin()
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
    }
}

#Preview {
    AuthView()
}

extension AuthView {
    
    func UserRegister() -> some View {
        VStack(spacing: 20){
            TextFieldView(placeholder: "Enter UserName", text: $authVM.txtUserName)
            TextFieldView(placeholder: "Enter Email Address", text: $authVM.txtRegisterEmail)
            
            GenderPicker(placeholder: "Select Gender", text: $authVM.txtGender)
            
            TextFieldView(placeholder: "Enter Phone Number", text: $authVM.txtPhoneNumber)
            
            SecureFieldView(placeholder: "Enter Password", text: $authVM.txtRegisterPassword)
            SecureFieldView(placeholder: "Enter Confirm Password", text: $authVM.txtConfirmPassword)
            
            ButtonView(title: "Sign Up") {
                self.authVM.clickOnRegisterBtn {
                    Alert.show(message: "Success...")
                }
            }
        }
        .padding(15)
    }
    
    func UserLogin() -> some View {
        VStack(spacing: 20) {
            TextFieldView(placeholder: "Enter Email Address", text: $authVM.txtLoginEmail)
            
            SecureFieldView(placeholder: "Enter Password", text: $authVM.txtLoginPassword)
            
            ButtonView(title: "Login") {
                self.authVM.clickOnLoginBtn {
                    Alert.show(message: "Success...")
                }
            }
            .padding(.top,15)
        }
        .padding(15)
    }
}
