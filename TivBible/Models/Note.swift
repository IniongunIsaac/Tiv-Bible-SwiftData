//
//  Note.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import Foundation
import SwiftData

@Model
final class Note {
    @Attribute(.unique) var id: String
    var takenOn: Date
    var verses: [NoteVerse]
    var comment: String
    
    init(id: String = UUID().uuidString,
        takenOn: Date = Date(),
        verses: [NoteVerse],
        comment: String
    ) {
        self.id = id
        self.takenOn = takenOn
        self.verses = verses
        self.comment = comment
    }
    
    var reference: String {
        guard let verse = verses.first, let chapter = verse.chapter, let book = chapter.book else { return "---" }
        return "\(book.name) \(chapter.number):\(verses.groups.joined(separator: ", "))".uppercased()
    }
    
    var shareText: String {
        "\(reference)\n\(verses.shareableText)"
    }
}
