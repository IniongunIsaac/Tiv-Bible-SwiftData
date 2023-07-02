//
//  MainContentScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI

struct MainContentScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    var body: some View {
        TabView(selection: $preferenceStore.selectedTabItem) {
            ReaderScreen()
                .tabItem {
                    Image(systemName: "book.circle")
                    Text("Read")
                }
                .tag(TabItem.read)
            
            HymnsScreen()
                .tabItem {
                    Image(systemName: "character.book.closed.fill")
                    Text("Atsam")
                }
                .tag(TabItem.hymns)
            
            MiscScreen()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Misc.")
                }
                .tag(TabItem.misc)
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(TabItem.settings)
        }
    }
}

#Preview("MainContentScreen") {
    MainContentScreen()
        .environmentObject(PreferenceStore())
}
