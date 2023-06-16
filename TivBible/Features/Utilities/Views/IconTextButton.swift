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
    var action: (() -> Void)? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            IconTextView(title: title, icon: icon)
        }
        .background(Color.secondaryLabel.cornerRadius(10))
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        
    }
}

#Preview("IconTextButton") {
    IconTextButton(title: "Share", icon: "square.and.arrow.up")
}
