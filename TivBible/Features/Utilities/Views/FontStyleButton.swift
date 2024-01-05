//
//  FontStyleButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct FontStyleButton: View {
    @StateObject private var preferenceStore = PreferenceStore()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                Text("FONT:")
                    .font(preferenceStore.font(size: 14, viewComponent: .labelText))
                
                Picker(selection: $preferenceStore.appFont, label: Text("")) {
                    ForEach(AppFont.allCases.sorted { $0.rawValue < $1.rawValue }, id: \.self) { option in
                        Text(option.displayName)
                            .scaledFont(option.rawValue, size: 15, maxSize: 18)
                            .tag(option)
                    }
                }
                .tint(.label)
                .pickerStyle(.menu)
                .padding(7)
                .background(.ultraThinMaterial)
            }
            .foregroundStyle(.secondary)
        }
    }
}

#Preview("FontStyleButton") {
    FontStyleButton()
        .padding()
}
