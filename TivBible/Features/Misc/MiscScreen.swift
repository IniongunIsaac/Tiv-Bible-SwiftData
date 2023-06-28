//
//  MiscScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI

struct MiscScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @State private var showBookmarks = false
    @State private var showHighlights = false
    @State private var showMiscList = false
    @State private var showNotes = false
    
    var body: some View {
        NavigationStack {
            List(MiscItem.allCases, id: \.self) { item in
                MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                    showBookmarks = item == .bookmarks
                    showHighlights = item == .highlights
                    showNotes = item == .notes
                }
                .listRowSeparator(.hidden)
            }
            .scrollIndicators(.never)
            .listStyle(.plain)
            .navigationTitle("Miscelleneous")
            .navigationDestination(isPresented: $showBookmarks) {
                MiscListScreen(miscItem: .bookmarks)
            }
            .navigationDestination(isPresented: $showHighlights) {
                MiscListScreen(miscItem: .highlights)
            }
        }
    }
}

#Preview("MiscScreen") {
    MiscScreen()
        .environmentObject(PreferenceStore())
}
