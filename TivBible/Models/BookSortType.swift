//
//  BookSortType.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import Foundation
import SwiftData

enum BookSortType: String, CaseIterable {
    case traditional
    case alphabetical
    
    var sortDescriptor: SortDescriptor<Book> {
        switch self {
        case .traditional:
            return SortDescriptor(\.order)
        case .alphabetical:
            return SortDescriptor(\.name)
        }
    }
}
