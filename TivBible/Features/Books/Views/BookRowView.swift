//
//  BookRowView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import SwiftUI

struct BookRowView: View {
    var book: Book
    private let gridItems: [GridItem] = Array(repeating: .init(.flexible()), count: Constants.chaptersPerRow)
    @Binding var isExpanded: Bool
    @EnvironmentObject private var preferenceStore: PreferenceStore
    private let spacing = 10.cgfloat
    
    var body: some View {
        DisclosureGroup(book.name, isExpanded: $isExpanded) {
            LazyVGrid(columns: gridItems, spacing: spacing) {
                ForEach(book.chapters.sorted(by: { $0.number < $1.number })) { chapter in
                    Button {
                        preferenceStore.currentChapterUUID = chapter.id
                    } label: {
                        Text("\(chapter.number)")
                            .foregroundStyle(Color.label)
                    }
                    .frame(width: itemWidth, height: 60)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 0))
                    .padding(.bottom, 10)
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 0)
        }
        .tint(.label)
        .font(preferenceStore.font(size: 16))
    }
    
    private var itemWidth: CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        let itemsPerRow = Constants.chaptersPerRow.cgfloat
        let totalSpacing = spacing * (itemsPerRow - 1)
        return (screenWidth / itemsPerRow) - (totalSpacing - 20)
    }
}
