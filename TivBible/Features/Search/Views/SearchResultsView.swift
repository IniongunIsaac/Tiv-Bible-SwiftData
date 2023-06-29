//
//  SearchResultsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 24/06/2023.
//

import SwiftUI

struct SearchResultsView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var viewModel: SearchViewModel
    @Binding var shouldDismiss: Bool
    @Binding var verseNumber: Int?
    
    var body: some View {
        List(viewModel.filteredVerses) { verse in
            NoteView(text: verse.text, reference: verse.reference)
            .padding(.bottom, 15)
            .onTapGesture {
                withAnimation {
                    preferenceStore.currentChapterUUID = verse.chapter?.id ?? ""
                    verseNumber = verse.number
                    shouldDismiss.toggle()
                }
            }
        }
        .scrollIndicators(.never)
        .listStyle(.plain)
    }
}
