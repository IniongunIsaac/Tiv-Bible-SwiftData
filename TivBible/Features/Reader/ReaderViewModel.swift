//
//  ReaderViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import Foundation
import SwiftData

@Observable
final class ReaderViewModel {
    var bookNameAndChapterNumber: String = ""
    var verses = [Verse]()
    
    private let preferenceStore = PreferenceStore()
    private let modelContainer = try! ModelContainer(for: [Book.self, Chapter.self, Verse.self])
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getVerses() {
        let chapterID = preferenceStore.currentChapterUUID
        let predicate = #Predicate<Chapter> {
            $0.id == chapterID
        }
        
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        do {
            guard let chapter = (try context.fetch(descriptor)).first else {
                return
            }
            bookNameAndChapterNumber = chapter.bookNameAndChapterNumber
            verses = chapter.verses.sorted(by: { $0.number < $1.number })
        } catch {
            print("unable to get verses")
        }
    }
    
    func refreshVerses() {
        verses = verses
    }
}
