//
//  LineSpacingView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct LineSpacingView: View {
    @StateObject private var preferenceStore = PreferenceStore()
    
    var body: some View {
        HStack(spacing: 15) {
            Text("LINE SPACING:")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            IconButton(iconName: "1.lane") {
                preferenceStore.updateLineSpacing(.small)
            }
            .background {
                if preferenceStore.lineSpacing == .small {
                    Color.green
                }
            }
            .cornerRadius(5)
            
            IconButton(iconName: "2.lane") {
                preferenceStore.updateLineSpacing(.normal)
            }
            .background {
                if preferenceStore.lineSpacing == .normal {
                    Color.green
                }
            }
            .cornerRadius(5)
            
            IconButton(iconName: "3.lane") {
                preferenceStore.updateLineSpacing(.large)
            }
            .background {
                if preferenceStore.lineSpacing == .large {
                    Color.green
                }
            }
            .cornerRadius(5)
        }
    }
}

#Preview {
    LineSpacingView()
        .padding()
}
