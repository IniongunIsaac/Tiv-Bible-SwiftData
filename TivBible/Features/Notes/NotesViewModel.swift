//
//  NotesViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import Foundation
import SwiftData

@Observable
final class NotesViewModel {
    //var notes
    
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getNotes() {
        let descriptor = FetchDescriptor<Note>()
        do {
            let notes = try context.fetch(descriptor)
            for note in notes {
                print("Note Verses => \(note.verses.count)")
            }
        } catch {
            print("unable to get notes")
        }
    }
}
