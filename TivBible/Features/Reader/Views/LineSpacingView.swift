//
//  LineSpacingView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct LineSpacingView: View {
    var body: some View {
        HStack(spacing: 15) {
            Text("LINE SPACING:")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            IconButton(iconName: "1.lane") {
                print("apply small spacing value")
            }
            
            IconButton(iconName: "2.lane") {
                print("apply medium spacing value")
            }
            
            IconButton(iconName: "3.lane") {
                print("apply large spacing value")
            }
        }
    }
}

#Preview {
    LineSpacingView()
        .padding()
}
