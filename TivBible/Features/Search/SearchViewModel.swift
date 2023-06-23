//
//  SearchViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 23/06/2023.
//

import Foundation
import SwiftData

@Observable
final class SearchViewModel {
    private let preferenceStore = PreferenceStore()
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    var searchText: String = ""
    var books = [Book]()
    var selectedBook: Book? = nil
    var chapters: [Chapter] {
        guard let selectedBook else { return [] }
        return selectedBook.chapters.sorted { $0.number < $1.number }
    }
    var selectedChapter: Chapter? = nil
    private var verses = [Verse]()
    var filteredVerses: [Verse] {
         if searchText.isEmpty {
            []
        } else {
            verses.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.text.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @MainActor
    func getBooks() {
        let sortDesc = SortDescriptor<Book>(\.order)
        let descriptor = FetchDescriptor(sortBy: [sortDesc])
        do {
            books = try context.fetch(descriptor)
        } catch {
            debugPrint("unable to get books")
        }
    }
    
    @MainActor
    func getVerses() {
        let descriptor = FetchDescriptor<Verse>()
        do {
            verses = try context.fetch(descriptor)
        } catch {
            debugPrint("unable to get verses")
        }
    }
}
