//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by differenz48 on 29/01/25.
//

import Foundation
import SwiftUI

class AuthViewModel: ObservableObject {
    
    @Published var txtUserName: String = ""
    @Published var txtLoginEmail: String = ""
    @Published var txtRegisterEmail: String = ""
    @Published var txtGender: String = ""
    @Published var txtPhoneNumber: String = ""
    @Published var txtLoginPassword: String = ""
    @Published var txtRegisterPassword: String = ""
    @Published var txtConfirmPassword: String = ""
    
}

extension AuthViewModel {
    
    ///`Login Button Click Event`
    func clickOnLoginBtn(completion: @escaping (()->())){
        if isValidForLogin() {
            completion()
        }
    }
    
    func isValidForLogin() -> Bool {
        if txtLoginEmail.isEmptyOrNull(txtLoginEmail) {
            Alert.show(message: "Please Enter Email")
            return false
        }
        else if !txtLoginEmail.isValidEmail() {
            Alert.show(message: "Please Enter Valid Email")
            return false
        }
        else if txtLoginPassword.isEmptyOrNull(txtLoginPassword) {
            Alert.show(message: "Please Enter Password")
            return false
        }
        return true
    }
    
    ///`Register Button Click Event`
    func clickOnRegisterBtn(completion: @escaping (()->())){
        if isValidForRegister() {
            completion()
        }
    }
    
    func isValidForRegister() -> Bool {
        
        if txtUserName.isEmptyOrNull(txtUserName){
            Alert.show(message: "Please Enter UserName")
            return false
        }
        else if txtRegisterEmail.isEmptyOrNull(txtRegisterEmail) {
            Alert.show(message: "Please Enter Email")
            return false
        }
        else if !txtRegisterEmail.isValidEmail() {
            Alert.show(message: "Please Enter Valid Email")
            return false
        }
        else if txtGender.isEmptyOrNull(txtGender) {
            Alert.show(message: "Please Select Gender")
            return false
        }
        else if txtPhoneNumber.isEmptyOrNull(txtPhoneNumber){
            Alert.show(message: "Please Enter Phone Number")
            return false
        }
        else if !txtPhoneNumber.isValidPhoneNumber() {
            Alert.show(message: "Please Enter Valid Phone Number(9-15)")
            return false
        }
        else if txtRegisterPassword.isEmptyOrNull(txtRegisterPassword) {
            Alert.show(message: "Please Enter Password")
            return false
        }
        else if txtConfirmPassword.isEmptyOrNull(txtConfirmPassword) {
            Alert.show(message: "Please Enter Confirm Password")
            return false
        }
        else if txtRegisterPassword != txtConfirmPassword {
            Alert.show(message: "Password Doesn't Match")
            return false
        }
        return true
    }
}
