//
//  VerseTapAction.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import Foundation
import SwiftUI

enum VerseTapAction: String, CaseIterable {
    case share = "Share"
    case bookmark = "Bookmark"
    case copy = "Copy"
    case takeNotes = "Take Notes"
    
    var iconName: String {
        switch self {
        case .share:
            return "square.and.arrow.up"
        case .bookmark:
            return "bookmark"
        case .copy:
            return "doc.on.doc"
        case .takeNotes:
            return "pencil.circle"
        }
    }
}
