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
    
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getBookmakrs() {
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
}
