//
//  MiscItem.swift
//  TivBible
//
//  Created by Isaac Iniongun on 25/06/2023.
//

import SwiftUI

enum MiscItem: String, CaseIterable {
    case bookmarks = "Bookmarks",
         highlights = "Highlights",
         notes = "Notes",
         apostlesCreed = "Akar a Puekarahar",
         commandments = "Atindi a Pue",
         theLordsPrayer = "Msen U Ter Wase",
         share = "Share with friends",
         rating = "Rate on Appstore",
         settings = "Settings"
    
    var iconName: String {
        switch self {
        case .bookmarks:
            return "bookmark"
        case .highlights:
            return "highlighter"
        case .notes:
            return "square.and.pencil.circle"
        case .apostlesCreed:
            return "text.book.closed"
        case .commandments:
            return "book.closed"
        case .theLordsPrayer:
            return "text.book.closed"
        case .share:
            return "square.and.arrow.up"
        case .rating:
            return "star.circle"
        case .settings:
            return "gearshape"
        }
    }
    
}
