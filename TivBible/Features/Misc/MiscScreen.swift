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
                /*Button {
                    miscItem = item
                    showBookmarks = item == .bookmarks
                } label: {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: item.iconName)
                        Text(item.rawValue)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            .foregroundStyle(.secondary)
                    }
                    .font(preferenceStore.font(size: 16))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 10)
                }
                .tint(.label)
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.bordered)*/
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
