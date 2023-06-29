//
//  Constants.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import Foundation
import SwiftData
import DeviceKit

enum Constants {
    static let dataModels: [any PersistentModel.Type] = [Book.self, Chapter.self, Verse.self, Note.self, NoteVerse.self]
    
    static let modelContainer: ModelContainer = try! ModelContainer(for: dataModels)
    
    enum FontSize {
        static let max: Double = currentDevice.isPhone ? 20 : 26
        
        static let min: Double = currentDevice.isPhone ? 13 : 18
        
        static let `default`: Double = currentDevice.isPhone ? 15 : 17
    }
    
    static let chaptersPerRow: Int = currentDevice.isPhone ? 5 : 10
}
