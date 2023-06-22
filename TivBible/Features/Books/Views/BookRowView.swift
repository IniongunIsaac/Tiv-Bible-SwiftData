//
//  BookRowView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import SwiftUI

struct BookRowView: View {
    var book: Book
    var action: ArgumentAction<Chapter>? = nil
    private let gridItems: [GridItem] = Array(repeating: .init(.flexible()),
                                              count: Constants.chaptersPerRow)
    @Binding var isExpanded: Bool
    
    var body: some View {
        DisclosureGroup(book.name, isExpanded: $isExpanded) {
            LazyVGrid(columns: gridItems, spacing: 10) {
                ForEach(book.chapters.sorted(by: { $0.number < $1.number })) { chapter in
                    Button {
                        action?(chapter)
                    } label: {
                        Text("\(chapter.number)")
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.label)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 3))
                    .padding(.bottom, 10)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, -8)
        }
        .tint(.label)
    }
}

//#Preview {
//    BookRowView(book: newBook)
//}
