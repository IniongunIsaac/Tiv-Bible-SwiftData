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
        HStack(spacing: 15) {
            Text("FONT SIZE:")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            FontSizeButton(type: .decrement) {
                preferenceStore.updateFontSize(type: .decrement)
            }
            
            FontSizeButton(type: .increment) {
                preferenceStore.updateFontSize(type: .increment)
            }
            
            Text("\(preferenceStore.fontSize.int)px")
        }
    }
}

#Preview {
    FontSizeView()
        .padding()
}
