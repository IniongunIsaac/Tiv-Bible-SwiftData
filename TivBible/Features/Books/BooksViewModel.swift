//
//  BooksViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
final class BooksViewModel {
    private var preferenceStore = PreferenceStore()
    private let modelContainer = try! ModelContainer(for: Book.self, Chapter.self, Verse.self, Note.self, NoteVerse.self, Hymn.self)
    
    var books = [Book]()
    var searchText: String = ""
    var isSearching = false
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            books
        } else {
            books.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getBooks() {
        let descriptor = FetchDescriptor(sortBy: [preferenceStore.bookSortType.sortDescriptor])
        do {
            books = try context.fetch(descriptor)
        } catch {
            debugPrint("unable to get books")
        }
    }
}
