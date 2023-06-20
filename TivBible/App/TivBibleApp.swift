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
        .modelContainer(for: Constants.dataModels)
    }
}

private extension TivBibleApp {
    func setupDependencyContainer() {
        DependencyContainer.register(type: SetupViewModel.self, SetupViewModel())
        DependencyContainer.register(type: ReaderViewModel.self, ReaderViewModel())
        DependencyContainer.register(type: PreferenceStore.self, PreferenceStore())
    }
}
