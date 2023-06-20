//
//  IconTextView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import SwiftUI

enum IconTextPosition {
    case iconLeft
    case iconRight
}

struct IconTextView: View {
    var title: String
    var icon: String
    var iconPosition: IconTextPosition = .iconRight
    var spacing: CGFloat = 8
    var padding: CGFloat = 2
    
    var body: some View {
        HStack(spacing: spacing) {
            if iconPosition == .iconLeft {
                Image(systemName: icon)
                Text(title)
            } else {
                Text(title)
                Image(systemName: icon)
            }
        }
        .foregroundStyle(Color.label)
        .padding(padding)
    }
}

#Preview("IconTextView") {
    IconTextView(title: "Share",
                 icon: "square.and.arrow.up",
                 iconPosition: .iconLeft)
    .background(.gray)
}
