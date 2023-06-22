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
    
    var body: some View {
        DisclosureGroup(book.name) {
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
            .animation(.spring)
            .padding(.leading, -23)
        }
        .tint(.secondary)
    }
}

//#Preview {
//    BookRowView(book: newBook)
//}

let chapters = Array(1...24).map { Chapter(number: $0) }
let newBook = Book(name: "Genese", order: 1, testament: 0, version: 0, chapters: chapters)
