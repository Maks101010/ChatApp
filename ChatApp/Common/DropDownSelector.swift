//
//  DropdownSelector.swift
//  ChatApp
//
//  Created by differenz48 on 31/01/25.
//

import Foundation
import SwiftUI

struct DropdownOption: Hashable {
    let key: String
    let value: String

    public static func == (lhs: DropdownOption, rhs: DropdownOption) -> Bool {
        return lhs.key == rhs.key
    }
}

struct DropdownSelector: View {
    @State private var shouldShowDropdown = false
    @State private var selectedOption: DropdownOption? = nil
    var cornerRadius: CGFloat = 5
    var placeholder: String
    var height: CGFloat = 40
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                withAnimation {
                    self.shouldShowDropdown.toggle()
                    self.hideKeyboard()
                }
            }) {
                HStack {
                    Text(selectedOption == nil ? placeholder : selectedOption!.value)
                        .dynamicTypeSize(.medium)
                        .font(.system(size: 15))
                        .foregroundColor(Color.black)
                        .foregroundColor(selectedOption == nil ? Color.gray: Color.black)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 10)
            .cornerRadius(10)
//            .frame(width: ScreenSize.SCREEN_WIDTH - 40, height: height)
            .frame(height: height)
            .markUnderline(color: !self.shouldShowDropdown ? Color.AppBrownColor : Color.clear, offset: 0)
            
            if self.shouldShowDropdown {
                VStack {
                    Dropdown(options: self.options, onOptionSelected: { option in
                        withAnimation {
                            shouldShowDropdown = false
                        }
                        selectedOption = option
                        self.onOptionSelected?(option)
                    })
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 5).fill(Color.white)
        )
        
    }
}

struct Dropdown: View {
    var options: [DropdownOption]
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(self.options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: self.onOptionSelected)
                }
            }
        }
        .frame(height: 90)
        .padding(.vertical, 5)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.AppBrownColor, lineWidth: 1)
        )
    }
}

struct DropdownRow: View {
    var option: DropdownOption
    var onOptionSelected: ((_ option: DropdownOption) -> Void)?

    var body: some View {
        Button(action: {
            if let onOptionSelected = self.onOptionSelected {
                onOptionSelected(self.option)
            }
        }) {
            HStack {
                Text(self.option.value)
                    .dynamicTypeSize(.medium)
                    .font(.system(size: 14))
                    .foregroundColor(Color.black)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

