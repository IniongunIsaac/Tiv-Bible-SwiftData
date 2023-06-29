//
//  IconOnlyButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 29/06/2023.
//

import SwiftUI

struct IconOnlyButton: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var iconName: String
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: iconName)
                .font(preferenceStore.font())
                .foregroundStyle(.secondary)
        }
        .tint(.secondary)
    }
}
