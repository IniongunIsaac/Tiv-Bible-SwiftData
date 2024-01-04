//
//  FontSizeButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

enum FontSizeButtonType {
    case increment
    case decrement
}

struct FontSizeButton: View {
    var type: FontSizeButtonType
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            HStack(spacing: 3) {
                if type == .increment {
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
//            .padding()
            .padding(.horizontal, 10)
            .padding(.vertical, 15)
        }
        .tint(.label)
        .background(.ultraThinMaterial)
        //.buttonBorderShape(.roundedRectangle)
        //.buttonStyle(.bordered)
    }
}

#Preview("FontSizeButton") {
    FontSizeButton(type: .decrement)
}
