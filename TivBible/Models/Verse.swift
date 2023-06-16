//
//  Verse.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftData

@Model
final class Verse {
    @Attribute(.unique) var id: String
    var title: String
    var text: String
    var number: Int
    var chapter: Chapter?
    
    init(id: String = UUID().uuidString,
        title: String,
        text: String,
        number: Int,
        chapter: Chapter? = nil
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.number = number
        self.chapter = chapter
    }
    
    var dictionary: [String : Any] {
        [
            "id": id,
            "title": title,
            "text": text,
            "number": number,
            "chapter": chapter?.dictionary ?? [:]
        ]
    }
}
