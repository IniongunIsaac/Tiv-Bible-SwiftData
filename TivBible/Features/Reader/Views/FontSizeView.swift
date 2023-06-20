//
//  FontSizeView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct FontSizeView: View {
    var body: some View {
        HStack(spacing: 15) {
            Text("FONT SIZE:")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            FontSizeButton(type: .decrement) {
                print("decrease font size")
            }
            
            FontSizeButton(type: .increament) {
                print("increase font size")
            }
            
            Text("15px")
        }
    }
}

#Preview {
    FontSizeView()
        .padding()
}
