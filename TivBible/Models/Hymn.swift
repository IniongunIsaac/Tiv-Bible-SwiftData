//
//  Hymn.swift
//  TivBible
//
//  Created by Isaac Iniongun on 02/07/2023.
//

import Foundation
import SwiftData

@Model
final class Hymn {
    @Attribute(.unique)
    var id: String
    var title: String
    var chorus: String
    var number: Int
    var verses: [String]
    
    init(id: String = UUID().uuidString,
         title: String,
         chorus: String,
         number: Int,
         verses: [String]
    ) {
        self.id = id
        self.title = title
        self.chorus = chorus
        self.number = number
        self.verses = verses
    }
    
    var versesText: String { verses.joined() }
    
    func contains(_ searchText: String) -> Bool {
        number.string.contains(searchText) || title.insensitiveContains(searchText) || versesText.insensitiveContains(searchText)
    }
    
    var shareableContent: String { "\(title)\n\n\(verses.enumerated().map { "\($0.offset + 1). \($0.element)" }.joined(separator: "\n\n")) Chorus: \(chorus)" }
}
