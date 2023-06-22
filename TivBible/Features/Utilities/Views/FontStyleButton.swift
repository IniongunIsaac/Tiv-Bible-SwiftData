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
        HStack(spacing: 20) {
            Text("FONT:")
                .font(.footnote)
            
            Spacer()
            
            Picker(selection: $preferenceStore.appFont, label: Text("")) {
                ForEach(AppFont.allCases.sorted { $0.rawValue < $1.rawValue }, id: \.self) { option in
                    Text(option.displayName)
                        .font(.custom(option.rawValue, size: 17))
                        .tag(option)
                }
            }
            .tint(.label)
            .pickerStyle(.menu)
            .padding(.horizontal, -10)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 1)
        )
        .foregroundStyle(.secondary)
    }
}

#Preview("FontStyleButton") {
    FontStyleButton()
        .padding()
}
