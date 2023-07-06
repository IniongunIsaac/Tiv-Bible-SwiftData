//
//  HymnsViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 02/07/2023.
//

import Foundation
import SwiftData

@Observable
final class HymnsViewModel {
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    var searchText: String = ""
    private var hymns = [Hymn]()
    var filteredHymns = [Hymn]()
    
    @MainActor
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
