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
        ScrollView(.horizontal) {
            HStack(spacing: 15) {
                Text("LINE SPACING:")
                    .font(preferenceStore.font(size: 14, viewComponent: .labelText))
                    .foregroundStyle(.secondary)
                
                IconButton(
                    iconName: "1.lane",
                    horizontalPadding: 15,
                    verticalPadding: 15,
                    tint: getIconTint(for: .small),
                    background: getIconBackground(for: .small)
                ) {
                    preferenceStore.updateLineSpacing(.small)
                }
                
                IconButton(
                    iconName: "2.lane",
                    horizontalPadding: 15,
                    verticalPadding: 15,
                    tint: getIconTint(for: .normal),
                    background: getIconBackground(for: .normal)
                ) {
                    preferenceStore.updateLineSpacing(.normal)
                }
                
                IconButton(
                    iconName: "3.lane",
                    horizontalPadding: 15,
                    verticalPadding: 15,
                    tint: getIconTint(for: .large),
                    background: getIconBackground(for: .large)
                ) {
                    preferenceStore.updateLineSpacing(.large)
                }
            }
        }
    }
    
    private func getIconBackground(for lineSpacing: LineSpacingType) -> Color {
        preferenceStore.lineSpacing == lineSpacing ? .systemGreen : .secondarySystemBackground
    }
    
    private func getIconTint(for lineSpacing: LineSpacingType) -> Color {
        preferenceStore.lineSpacing == lineSpacing ? .white : .label
    }
}

//#Preview {
//    LineSpacingView()
//        .padding()
//}
