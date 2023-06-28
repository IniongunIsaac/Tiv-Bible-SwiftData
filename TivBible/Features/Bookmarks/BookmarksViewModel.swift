//
//  BookmarksViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 25/06/2023.
//

import Foundation
import SwiftData

@Observable
final class BookmarksViewModel {
    var bookmarks = [Verse]()
    var toastMessage: ToastMessage = .empty
    
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getBookmarks() {
        let predicate = #Predicate<Verse> {
            $0.isBookmarked
        }
        let dateSortDesc = SortDescriptor<Verse>(\.bookmarkDate, order: .reverse)
        let numberSortDesc = SortDescriptor<Verse>(\.number, order: .forward)
        let fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: [dateSortDesc, numberSortDesc])
        
        do {
            bookmarks = try context.fetch(fetchDescriptor)
        } catch {
            debugPrint("Unable to get bookmarks")
        }
    }
    
    @MainActor
    func deleteBookmark(_ bookmark: Verse?) {
        guard let bookmark else { return }
        bookmark.isBookmarked = false
        bookmark.bookmarkDate = nil
        toastMessage = .success("Bookmark deleted!")
        getBookmarks()
    }
    
    @MainActor
    func clearBookmarks() {
        guard bookmarks.isNotEmpty else { return }
        bookmarks.forEach {
            $0.isBookmarked = false
            $0.bookmarkDate = nil
        }
        toastMessage = .success("Bookmarks deleted!")
        getBookmarks()
    }
}
