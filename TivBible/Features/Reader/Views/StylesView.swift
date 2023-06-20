//
//  StylesView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct StylesView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            Text("STYLES")
                .offset(y: -28)
            
            FontSizeView()
            
            LineSpacingView()
            
            FontStyleButton()
            
            ThemeOptionsView()
        }
        .padding(.horizontal)
        .overlay(alignment: .topTrailing) {
            Button {
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            .tint(.label)
            .offset(x: -18, y: -30)
        }
    }
}

#Preview("StylesView") {
    StylesView()
        .background(.ultraThinMaterial)
        .previewLayout(.sizeThatFits)
}
