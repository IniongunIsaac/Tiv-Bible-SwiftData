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
    private let modelContainer = try! ModelContainer(for: Book.self, Chapter.self, Verse.self, Note.self, Hymn.self)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    var searchText: String = ""
    var books = [Book]()
    var selectedBook: Book? = nil {
        didSet {
            search()
        }
    }
    var chapters: [Chapter] {
        guard let selectedBook else { return [] }
        return selectedBook.chapters.sorted { $0.number < $1.number }
    }
    var selectedChapter: Chapter? = nil {
        didSet {
            search()
        }
    }
    private var verses = [Verse]()
    var filteredVerses = [Verse]()
    
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
    
    func search() {
        //TODO: Fitering like this using #Predicate is just a mess
        /*guard searchText.isNotEmpty else { return [] }
        
        let searchTerm = searchText.lowercased()
        let predicate = #Predicate<Verse> {
            $0.text.contains(searchTerm) || $0.title.contains(searchTerm)
        }
        let descriptor = FetchDescriptor(predicate: predicate)
        
        do {
            return try context.fetch(descriptor)
        } catch {
            return []
        }*/
        if searchText.isEmpty {
            filteredVerses =  []
        } else {
            var filtered = verses.filter { $0.contains(searchText) }.sorted { $0.number < $1.number }
            
            if let selectedBook {
                filtered = filtered.filter { $0.chapter?.book == selectedBook }
            }
            
            if let selectedChapter {
                filtered = filtered.filter { $0.chapter == selectedChapter }
            }
            
            filteredVerses = filtered
        }
    }
    
    func endSearch() {
        filteredVerses = []
    }
}
