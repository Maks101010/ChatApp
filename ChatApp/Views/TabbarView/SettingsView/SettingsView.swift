//
//  SettingsView.swift
//  ChatApp
//
//  Created by differenz48 on 31/01/25.
//

import SwiftUI

struct SettingsView: View {
    
    ///`Declaration`
    @State var txtUsername: String = ""
    @State var txtGender: String = ""
    @State var txtPhoneNumber: String = ""
    @State var txtPassword: String = ""
    @StateObject var viewModel: ChatAppModel = .shared
    
    static var uniqueKey: String {
        UUID().uuidString
    }
    
    static let options: [DropdownOption] = [
        DropdownOption(key: uniqueKey, value: Gender.kMale),
        DropdownOption(key: uniqueKey, value: Gender.kFemale),
        DropdownOption(key: uniqueKey, value: Gender.kOther)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    CommonText(title: "User Profile", fontSize: 25, weight: .semibold, foregroundColor: Color.AppBrownColor)
                    VStack(alignment: .leading) {
                        CommonText(title: "Email", fontSize: 18, foregroundColor: Color.AppBrownColor)
                        CommonTextFieldForProfile(nameOfField: .constant(UserDefaults.standard.loginUser?.email ?? ""), placeholderText: "")
                            .disabled(true)
                        CommonText(title: "Gender", fontSize: 18, foregroundColor: Color.AppBrownColor)
                        DropdownSelector(cornerRadius: 25, placeholder: "", height: 44, options: SettingsView.options) { option in
                            self.txtGender = option.value
                        }
                        CommonText(title: "Phone Number", fontSize: 18, foregroundColor: Color.AppBrownColor)
                        CommonTextFieldForProfile(nameOfField: $txtPhoneNumber, placeholderText: "")
                            .keyboardType(.numberPad)
                        CommonText(title: "Password", fontSize: 18, foregroundColor: Color.AppBrownColor)
                        CommonTextFieldForProfile(nameOfField: $txtPassword, placeholderText: "")
                    }
                    .padding(15)
                    .padding(.top, 10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.clear)
                            .stroke(.appBrown, lineWidth: 2)
                    }
                }
                Spacer()
                
            }
            .padding(.horizontal, 20)
            
            Button {
                FireBaseAuthService.shared.logoutUser {
                    viewModel.isDashBoardShowing = false
                }
            } label: {
                CommonText(title: "Logout",fontSize: 18,foregroundColor: Color.AppBrownColor)
                    .padding(12)
                    .padding(.horizontal,10)
                    .overlay {
                        RoundedRectangle(cornerRadius: 18)
                            .fill(Color.clear)
                            .stroke(.appBrown, lineWidth: 2)
                    }
                    .padding(.bottom,10)
            }

        }
        .onAppear {
            self.txtUsername = UserDefaults.standard.loginUser?.userName ?? ""
            self.txtPhoneNumber = UserDefaults.standard.loginUser?.phoneNumber ?? ""
            self.txtGender = UserDefaults.standard.loginUser?.gender ?? ""
            self.txtPassword = UserDefaults.standard.loginUser?.password ?? ""
        }
    }
}

#Preview {
    SettingsView()
}
