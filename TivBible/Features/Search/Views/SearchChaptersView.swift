//
//  SearchChaptersView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 24/06/2023.
//

import SwiftUI

struct SearchChaptersView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                Button {
                    withAnimation {
                        viewModel.selectedChapter = nil
                    }
                } label: {
                    Text("All")
                        .foregroundStyle(Color.label)
                        .font(preferenceStore.font(size: 14))
                        .padding(.horizontal, 5)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .background {
                    if viewModel.selectedChapter == nil {
                        Color.systemGreen.cornerRadius(20)
                    }
                }
                
                ForEach(viewModel.chapters) { chapter in
                    Button {
                        withAnimation {
                            viewModel.selectedChapter = chapter
                        }
                    } label: {
                        Text("\(chapter.number)")
                            .foregroundStyle(Color.label)
                            .font(preferenceStore.font(size: 14))
                            .padding(.horizontal, 6)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .background {
                        if viewModel.selectedChapter == chapter {
                            Color.systemGreen.cornerRadius(20)
                        }
                    }
                }
            }
        }
        .frame(height: 50)
    }
}
