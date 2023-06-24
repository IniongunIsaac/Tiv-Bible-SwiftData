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
    
    var body: some View {
        List(viewModel.filteredVerses) { verse in
            HStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(verse.text)
                        .font(preferenceStore.font(size: 16))
                    Text(verse.reference)
                        .font(preferenceStore.font(size: 15))
                        .fontWeight(.bold)
                }
                
                Spacer()
            }
            .padding(.bottom, 15)
        }
        .scrollIndicators(.never)
        .listStyle(.plain)
    }
}