//
//  IconButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct IconButton: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var iconName: String
    var horizontalPadding: CGFloat = 4
    var verticalPadding: CGFloat = 6
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: iconName)
                .font(preferenceStore.font())
                .padding(.horizontal, horizontalPadding)
                .padding(.vertical, verticalPadding)
        }
        .tint(.label)
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.bordered)
    }
}

#Preview {
    IconButton(iconName: "1.lane")
        .environmentObject(PreferenceStore())
}
//ButtonBorderShape BorderedButtonStyle
