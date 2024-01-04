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
        VStack(alignment: .leading, spacing: 6) {
            Text("THEME:")
                .font(preferenceStore.font(size: 14, viewComponent: .labelText))
                .foregroundStyle(.secondary)
            
            Picker(selection: $preferenceStore.appTheme, label: Text("")) {
                ForEach(AppTheme.allCases, id: \.self) { option in
                    Text(option.rawValue.uppercased())
                        .tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview("AppThemesView") {
    AppThemesView()
        .padding()
}
