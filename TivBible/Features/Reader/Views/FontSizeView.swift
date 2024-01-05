//
//  FontSizeView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct FontSizeView: View {
    @StateObject private var preferenceStore = PreferenceStore()
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                Text("FONT SIZE:")
                    .font(preferenceStore.font(size: 14, viewComponent: .labelText))
                    .foregroundStyle(.secondary)
                
                FontSizeButton(type: .decrement) {
                    preferenceStore.updateFontSize(type: .decrement)
                }
                
                FontSizeButton(type: .increment) {
                    preferenceStore.updateFontSize(type: .increment)
                }
                
                Text("\(preferenceStore.fontSize.int)px")
                    .font(preferenceStore.font(size: 15))
            }
        }
    }
}

#Preview {
    FontSizeView()
        .padding()
}
