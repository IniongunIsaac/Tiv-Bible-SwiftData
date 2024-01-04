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
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.colorScheme) private var systemColorScheme
    
    private var colorScheme: ColorScheme {
        switch preferenceStore.appTheme {
        case .system:
            return systemColorScheme
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    init() {
        setupDependencyContainer()
    }

    var body: some Scene {
        WindowGroup {
            if preferenceStore.hasSetupDB {
                MainContentScreen()
                    .preferredColorScheme(colorScheme)
                    .environmentObject(PreferenceStore())
            } else {
                SetupScreen()
                    .preferredColorScheme(colorScheme)
            }
        }
        .modelContainer(for: Constants.dataModels)
        .onChange(of: scenePhase) { _, newScenePhase in
            if newScenePhase == .inactive || newScenePhase == .background {
                preferenceStore.selectedTabItem = .read
            }
        }
    }
}

private extension TivBibleApp {
    func setupDependencyContainer() {
        DependencyContainer.register(type: SetupViewModel.self, SetupViewModel())
        DependencyContainer.register(type: ReaderViewModel.self, ReaderViewModel())
        DependencyContainer.register(type: PreferenceStore.self, PreferenceStore())
        DependencyContainer.register(type: BooksViewModel.self, BooksViewModel())
    }
    
    func printFonts() {
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
    }
}
