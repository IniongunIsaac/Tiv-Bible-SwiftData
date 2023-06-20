//
//  FontStyleButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct FontStyleButton: View {
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            
        } label: {
            HStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("FONT:")
                        .font(.footnote)
                    
                    Text("Gentium Plus Bold Gold Minus")
                        .lineLimit(1)
                        .foregroundStyle(Color.label)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1)
            )
        }
        .tint(.secondary)
    }
}

#Preview("FontStyleButton") {
    FontStyleButton()
        .padding()
}
