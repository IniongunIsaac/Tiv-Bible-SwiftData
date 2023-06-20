//
//  Constants.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import Foundation
import SwiftData

enum Constants {
    static let dataModels: [any PersistentModel.Type] = [Book.self, Chapter.self, Verse.self, Note.self]
    
    static let modelContainer: ModelContainer = try! ModelContainer(for: dataModels)
}
