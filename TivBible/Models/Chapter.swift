//
//  Chapter.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftData

@Model
final class Chapter {
    @Attribute(.unique) var id: String
    var number: Int
    @Relationship(inverse: \Verse.chapter)
    var verses: [Verse]
    var book: Book?
    
    init(
        id: String = UUID().uuidString,
        number: Int,
        verses: [Verse] = []
    ) {
        self.id = id
        self.number = number
        self.verses = verses
    }
    
    var bookNameAndChapterNumber: String {
        guard let book else { return "None" }
        return "\(book.name) \(number)"
    }
}
