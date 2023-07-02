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
    var padding: CGFloat = 4
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
        .background(Color.tertiaryLabel .cornerRadius(4))
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 4))
    }
}

//#Preview("IconTextButton") {
//    IconTextButton(title: "Share".uppercased(), icon: "square.and.arrow.up")
//}
