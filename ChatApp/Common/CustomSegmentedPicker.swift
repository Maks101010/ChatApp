//
//  CustomSegmentedPicker.swift
//  ChatApp
//
//  Created by differenz48 on 29/01/25.
//

import SwiftUI

struct SegmentedPicker: View {
    @Binding var selectedIndex: Int
    var items: [String] = ["Login", "Register"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<items.count, id: \.self) { index in
                Button(action: {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.selectedIndex = index
                        }
                    }
                }) {
                    VStack(spacing: 0) {
                        Text(items[index])
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color.AppBrownColor)
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .background(Color.white)
                        
                        Rectangle()
                            .fill(index == self.selectedIndex ? Color.AppBrownColor : Color.white)
                            .frame(height: 3)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
