//
//  MiscItemAction.swift
//  TivBible
//
//  Created by Isaac Iniongun on 27/06/2023.
//

import Foundation

enum MiscItemAction: String, CaseIterable {
    case readFullChapter = "Read full chapter"
    case share = "Share"
    case copy = "Copy"
    case delete = "Delete"
    
    var iconName: String {
        switch self {
        case .readFullChapter:
            return "book"
        case .share:
            return "square.and.arrow.up"
        case .copy:
            return "doc.on.doc"
        case .delete:
            return "trash"
        }
    }
}
