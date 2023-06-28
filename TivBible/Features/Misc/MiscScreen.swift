//
//  MiscScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI

struct MiscScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @State private var miscItem: MiscItem? = nil
    @State private var showBookmarks = false
    
    var body: some View {
        NavigationStack {
            List(MiscItem.allCases, id: \.self) { item in
                MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                    showBookmarks = item == .bookmarks
                }
                .listRowSeparator(.hidden)
            }
            .scrollIndicators(.never)
            .listStyle(.plain)
            .navigationTitle("Miscelleneous")
            .navigationDestination(isPresented: $showBookmarks) {
                BookmarksScreen()
            }
        }
    }
}

#Preview("MiscScreen") {
    MiscScreen()
        .environmentObject(PreferenceStore())
}
