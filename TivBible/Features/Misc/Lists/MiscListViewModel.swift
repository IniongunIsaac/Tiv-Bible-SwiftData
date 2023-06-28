//
//  MiscListViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
final class MiscListViewModel {
    var verses = [Verse]()
    var toastMessage: ToastMessage = .empty
    var miscItem: MiscItem = .bookmarks
    
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getVerses() {
        var predicate: Predicate<Verse>
        var dateSortDesc: SortDescriptor<Verse>
        if miscItem == .bookmarks {
            dateSortDesc = SortDescriptor(\.bookmarkDate, order: .reverse)
            predicate = #Predicate<Verse> {
                $0.isBookmarked
            }
        } else {
            dateSortDesc = SortDescriptor(\.highlightDate, order: .reverse)
            predicate = #Predicate<Verse> {
                $0.highlightDate != nil
            }
        }
        let numberSortDesc = SortDescriptor<Verse>(\.number, order: .forward)
        let fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: [dateSortDesc, numberSortDesc])
        
        do {
            verses = try context.fetch(fetchDescriptor)
        } catch {
            debugPrint("Unable to get bookmarks")
        }
    }
    
    @MainActor
    func delete(_ verse: Verse?) {
        guard let verse else { return }
        var text = ""
        
        if miscItem == .bookmarks {
            text = "Bookmark"
            verse.isBookmarked = false
            verse.bookmarkDate = nil
        } else {
            text = "Highlight"
            verse.highlightColor = ""
            verse.highlightDate = nil
        }
        
        toastMessage = .success("\(text) deleted!")
        
        getVerses()
    }
    
    @MainActor
    func clear() {
        guard verses.isNotEmpty else { return }
        
        if miscItem == .bookmarks {
            verses.forEach {
                $0.isBookmarked = false
                $0.bookmarkDate = nil
            }
        } else {
            verses.forEach {
                $0.highlightColor = ""
                $0.highlightDate = nil
            }
        }
        
        toastMessage = .success("\(miscItem.rawValue) deleted!")
        getVerses()
    }
    
    func fillColor(for verse: Verse) -> Color {
        miscItem == .highlights && verse.highlightColor.isNotEmpty ? verse.highlightColor.color : .label
    }
}
