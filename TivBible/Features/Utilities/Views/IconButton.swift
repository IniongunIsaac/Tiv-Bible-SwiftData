//
//  IconButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct IconButton: View {
    var iconName: String
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: iconName)
                .font(.title)
                .padding(.horizontal, 4)
                .padding(.vertical, 6)
        }
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.bordered)
    }
}

#Preview {
    IconButton(iconName: "1.lane")
}
