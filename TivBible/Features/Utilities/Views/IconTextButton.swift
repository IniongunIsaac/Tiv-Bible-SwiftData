//
//  IconTextButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import SwiftUI

struct IconTextButton: View {
    var title: String
    var icon: String
    var iconPosition: IconTextPosition = .iconRight
    var spacing: CGFloat = 8
    var padding: CGFloat = 2
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            IconTextView(title: title,
                         icon: icon,
                         iconPosition: iconPosition,
                         spacing: spacing,
                         padding: padding)
        }
        .background(Color.tertiaryLabel .cornerRadius(10))
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        
    }
}

#Preview("IconTextButton") {
    IconTextButton(title: "Share", icon: "square.and.arrow.up")
}
