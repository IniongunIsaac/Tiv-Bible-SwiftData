//
//  AppThemesView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct AppThemesView: View {
    @StateObject private var preferenceStore = PreferenceStore()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center, spacing: 20) {
                Text("THEME:")
                    .font(preferenceStore.font(size: 14, viewComponent: .labelText))
                    .foregroundStyle(.secondary)
                
                Picker(selection: $preferenceStore.appTheme, label: Text("")) {
                    ForEach(AppTheme.allCases, id: \.self) { option in
                        Text(option.rawValue.capitalized)
                            .tag(option)
                    }
                }
                .tint(.label)
                .pickerStyle(.menu)
                .padding(7)
                .background(.ultraThinMaterial)
            }
        }
    }
}

#Preview("AppThemesView") {
    AppThemesView()
        .padding()
}
