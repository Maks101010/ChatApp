//
//  SearchBarView.swift
//  ChatApp
//
//  Created by differenz48 on 31/01/25.
//

import SwiftUI

struct SearchBarView: View {
    @FocusState private var isFocused: Bool
    ///`Declarations`
    @Binding var searchText: String
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.black)
                    .frame(width: 20,height: 20)
                
                TextField("", text: $searchText, prompt: Text("Search").foregroundColor(Color.black.opacity(0.5)))
                    .dynamicTypeSize(.medium)
                    .focused($isFocused)
                    .font(.system(size: 16))
                    .foregroundColor(Color.black)
                    .accentColor(.black)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .onSubmit {
                        isFocused = false
                    }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .padding(.horizontal, 6)
            .background(Color.gray).opacity(0.6)
            .cornerRadius(5)

        }
    }
}
