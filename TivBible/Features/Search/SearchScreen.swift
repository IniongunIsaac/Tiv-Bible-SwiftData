//
//  SearchScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 23/06/2023.
//

import SwiftUI

struct SearchScreen: View {
    @Bindable private var viewModel = SearchViewModel()
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.dismiss) private var dismiss
    @State private var shouldDismiss = false
    @Binding var verseNumber: Int?
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 5) {
                SearchBooksView(viewModel: viewModel)
                
                SearchChaptersView(viewModel: viewModel)
                    .visible(viewModel.chapters.isNotEmpty)
                
                Spacer()
                
                ZStack {
                    if viewModel.filteredVerses.isNotEmpty {
                        SearchResultsView(viewModel: viewModel,
                                          shouldDismiss: $shouldDismiss,
                                          verseNumber: $verseNumber)
                            .padding(.horizontal, -20)
                    } else {
                        EmptyStateView(message: "Results will appear here")
                    }
                }
                
                Spacer()
            }
            .onAppear {
                viewModel.getBooks()
                runAfter(0.3) {
                    viewModel.getVerses()
                }
            }
            .padding(.horizontal)
            .navigationTitle("Bible Search")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                            .fontWeight(.semibold)
                            .font(preferenceStore.font(size: 16))
                    }
                    .tint(.systemRed)
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search")
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .onSubmit(of: .search) {
                viewModel.search()
            }
            .onChange(of: viewModel.searchText) {
                if viewModel.searchText.isEmpty {
                    viewModel.endSearch()
                }
            }
            .onChange(of: shouldDismiss) {
                dismiss()
            }
            .font(preferenceStore.font(size: 15))
        }
    }
}
