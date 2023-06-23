//
//  SearchBooksView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 24/06/2023.
//

import SwiftUI

struct SearchBooksView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                Button {
                    withAnimation {
                        viewModel.selectedBook = nil
                    }
                } label: {
                    Text("All")
                        .foregroundStyle(Color.label)
                        .font(preferenceStore.font(size: 14))
                        .padding(.horizontal, 6)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .background {
                    if viewModel.selectedBook == nil {
                        Color.systemGreen.cornerRadius(20)
                    }
                }
                
                ForEach(viewModel.books) { book in
                    Button {
                        withAnimation {
                            viewModel.selectedBook = book
                        }
                    } label: {
                        Text(book.name)
                            .foregroundStyle(Color.label)
                            .font(preferenceStore.font(size: 14))
                            .padding(.horizontal, 4)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .background {
                        if viewModel.selectedBook == book {
                            Color.systemGreen.cornerRadius(20)
                        }
                    }
                }
            }
        }
        .frame(height: 50)
    }
}
