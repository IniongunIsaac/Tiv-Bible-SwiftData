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
    var takenOn: Date
    var verses: [Verse]
    var comment: String
    
    init(takenOn: Date = Date(),
        verses: [Verse],
        comment: String
    ) {
        self.takenOn = takenOn
        self.verses = verses
        self.comment = comment
    }
}
