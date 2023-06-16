//
//  TivBibleApp.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import SwiftUI
import SwiftData

@main
struct TivBibleApp: App {
    
    @StateObject private var preferenceStore = PreferenceStore()
    
    init() {
        setupDependencyContainer()
    }

    var body: some Scene {
        WindowGroup {
            if preferenceStore.hasSetupDB {
                MainContentScreen()
            } else {
                SetupScreen()
            }
        }
        .modelContainer(for: [Book.self, Chapter.self, Verse.self])
    }
}

private extension TivBibleApp {
    func setupDependencyContainer() {
        /*DependencyContainer.register(type: BooksDataStore.self, as: .singleton, BooksDataStore.shared)
        DependencyContainer.register(type: ChaptersDataStore.self, as: .singleton, ChaptersDataStore.shared)
        DependencyContainer.register(type: VersesDataStore.self, as: .singleton, VersesDataStore.shared)*/
    }
}
