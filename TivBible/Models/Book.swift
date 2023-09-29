//
//  Book.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftData

@Model
final class Book {
    @Attribute(.unique) var id: String
    var name: String
    var order: Int
    var testament: Int
    var version: Int
    @Relationship(inverse: \Chapter.book)
    var chapters: [Chapter]
    
    init(id: String = UUID().uuidString,
        name: String,
        order: Int,
        testament: Int,
        version: Int,
        chapters: [Chapter] = []
    ) {
        self.id = id
        self.name = name
        self.order = order
        self.testament = testament
        self.version = version
        self.chapters = chapters
    }
}
