//
//  MainContentScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI

struct MainContentScreen: View {
    var body: some View {
        TabView {
            ReaderScreen()
                .tabItem {
                    Image(systemName: "book.circle")
                    Text("Read")
                }
            
            MiscScreen()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Misc.")
                }
            
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

#Preview {
    MainContentScreen()
}
