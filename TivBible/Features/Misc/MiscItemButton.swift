//
//  MiscItemButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 27/06/2023.
//

import SwiftUI

struct MiscItemButton: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    let title: String
    let iconName: String
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: iconName)
                Text(title)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                    .foregroundStyle(.secondary)
            }
            .font(preferenceStore.font(size: 16))
            .padding(.horizontal, 5)
            .padding(.vertical, 8)
            .foregroundStyle(Color.label)
        }
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.bordered)
    }
}

#Preview {
    MiscItemButton(title: "Delete", iconName: "trash")
        .padding()
        .environmentObject(PreferenceStore())
}
