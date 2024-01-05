//
//  MoreScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 06/07/2023.
//

import SwiftUI

struct MoreScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    private var verseActions: [MiscItem] = [.bookmarks, .highlights, .notes]
    private var bibleActions: [MiscItem] = [.apostlesCreed, .commandments, .theLordsPrayer]
    private var otherActions: [MiscItem] = [.share, .rating, .settings]
    @State private var showBookmarks = false
    @State private var showHighlights = false
    @State private var showMiscList = false
    @State private var showNotes = false
    @State private var showApostlesCreed = false
    @State private var showCommandments = false
    @State private var showTheLordsPrayer = false
    @State private var showSettings = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("YOUR VERSE ACTIONS") {
                    ForEach(verseActions, id: \.self) { item in
                        MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                            didTapMiscItem(item)
                        }
                    }
                }
                
                Section("INSIDE THE BIBLE") {
                    ForEach(bibleActions, id: \.self) { item in
                        MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                            didTapMiscItem(item)
                        }
                    }
                }
                
                Section("OTHERS") {
                    ForEach(otherActions, id: \.self) { item in
                        MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                            didTapMiscItem(item)
                        }
                    }
                }
                
            }
            .font(preferenceStore.font(size: 11))
            .listStyle(.plain)
            .scrollIndicators(.never)
            .navigationTitle("More Activities")
            .navigationDestination(isPresented: $showBookmarks) {
                MiscListScreen(miscItem: .bookmarks)
            }
            .navigationDestination(isPresented: $showHighlights) {
                MiscListScreen(miscItem: .highlights)
            }
            .navigationDestination(isPresented: $showNotes) {
                NotesScreen()
            }
            .sheet(isPresented: $showApostlesCreed) {
                ApostlesCreedView()
                    .presentationDetents([.fraction(0.85)])
            }
            .sheet(isPresented: $showCommandments) {
                CommandmentsView()
            }
            .sheet(isPresented: $showTheLordsPrayer) {
                TheLordsPrayerView()
                    .presentationDetents([.height(350)])
            }
            .sheet(isPresented: $showSettings) {
                StylesView(showStyles: $showSettings)
                    .presentationDetents([.fraction(0.5)])
            }
        }
    }
    
    private func didTapMiscItem(_ item: MiscItem) {
        switch item {
        case .bookmarks:
            showBookmarks.toggle()
        case .highlights:
            showHighlights.toggle()
        case .notes:
            showNotes.toggle()
        case .apostlesCreed:
            showApostlesCreed.toggle()
        case .commandments:
            showCommandments.toggle()
        case .theLordsPrayer:
            showTheLordsPrayer.toggle()
        case .share:
            Constants.shareableText.share()
        case .rating:
            rateApp()
        case .settings:
            showSettings.toggle()
        }
    }
}

#Preview("MoreScreen") {
    MoreScreen()
        .environmentObject(PreferenceStore())
}
