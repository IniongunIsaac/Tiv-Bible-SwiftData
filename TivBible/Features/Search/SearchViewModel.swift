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
}
