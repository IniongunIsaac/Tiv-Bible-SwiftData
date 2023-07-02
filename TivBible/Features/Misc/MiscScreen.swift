//
//  MiscScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI
import StoreKit
import UIKit

struct MiscScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @State private var showBookmarks = false
    @State private var showHighlights = false
    @State private var showMiscList = false
    @State private var showNotes = false
    @State private var showApostlesCreed = false
    @State private var showCommandments = false
    @State private var showTheLordsPrayer = false
    
    var body: some View {
        NavigationStack {
            List(MiscItem.allCases, id: \.self) { item in
                MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                    didTapMiscItem(item)
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
            .navigationDestination(isPresented: $showNotes) {
                NotesScreen()
            }
            .sheet(isPresented: $showApostlesCreed) {
                ApostlesCreedView()
            }
            .sheet(isPresented: $showCommandments) {
                CommandmentsView()
            }
            .sheet(isPresented: $showTheLordsPrayer) {
                TheLordsPrayerView()
                    .presentationDetents([.height(350)])
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
        }
    }
    
    private func rateApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else {
            print("WindowScene not available!!!")
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
}

#Preview("MiscScreen") {
    MiscScreen()
        .environmentObject(PreferenceStore())
}
