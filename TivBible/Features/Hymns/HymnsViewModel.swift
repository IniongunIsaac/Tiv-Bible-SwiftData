//
//  HymnsViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 02/07/2023.
//

import Foundation
import SwiftData

//TODO: I can't explain this but the new '@Observable' macro approach didn't work for this functionality so I had to use the '@ObservableObject' approach and it works sadly!
//@Observable
@MainActor
final class HymnsViewModel: ObservableObject {
    private let modelContainer = try! ModelContainer(for: Book.self, Chapter.self, Verse.self, Note.self, Hymn.self)
    
    //@MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @Published var searchText: String = ""
    private var hymns = [Hymn]()
    @Published var filteredHymns = [Hymn]()
    
    //@MainActor
    func getHymns() {
        let sortDescriptor = SortDescriptor<Hymn>(\.number)
        let fetchDescriptor = FetchDescriptor(sortBy: [sortDescriptor])
        do {
            let hymns = try context.fetch(fetchDescriptor)
            self.hymns = hymns
            filteredHymns = hymns
        } catch {
            debugPrint("Unable to get hymns")
        }
    }
    
    func search() {
        if searchText.isEmpty {
            endSearch()
        } else {
            filteredHymns = hymns.filter { $0.contains(searchText) }
        }
    }
    
    func endSearch() {
        filteredHymns = hymns
    }
}
