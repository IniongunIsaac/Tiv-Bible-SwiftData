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
    @Attribute(.unique) var id: UUID
    var number: Int
    var verses: [Verse]
    var book: Book?
    
    init(id: UUID = UUID(),
        number: Int,
        verses: [Verse] = [],
        book: Book? = nil
    ) {
        self.id = id
        self.number = number
        self.verses = verses
        self.book = book
    }
    
    var dictionary: [String : Any] {
        [
            "id": id,
            "number": number,
            "verses": verses.map { $0.dictionary },
            "book": book?.dictionary ?? [:]
        ]
    }
}
