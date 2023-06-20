//
//  FontSizeButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

enum FontSizeButtonType {
    case increament
    case decrement
}

struct FontSizeButton: View {
    var type: FontSizeButtonType
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 5) {
                if type == .increament {
                    Image(systemName: "textformat.size")
                    
                    Image(systemName: "plus")
                        .font(.footnote)
                        .fontWeight(.semibold)
                } else {
                    Image(systemName: "minus")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Image(systemName: "textformat.size")
                }
                    
            }
            .padding(.horizontal, 0)
            .padding(.vertical, 12)
        }
        .tint(.label)
        .buttonBorderShape(.roundedRectangle)
        .buttonStyle(.bordered)
    }
}

#Preview("FontSizeButton") {
    FontSizeButton(type: .decrement)
}
