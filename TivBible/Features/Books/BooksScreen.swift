//
//  BooksScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import SwiftUI

struct BooksScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Provided private var viewModel: BooksViewModel
    @StateObject private var preferenceStore = PreferenceStore()
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.books) { book in
                        BookRowView(book: book) { chapter in
                            
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .scrollIndicators(.never)
                .listStyle(.plain)
                
                Picker(selection: $preferenceStore.bookSortType, label: Text("")) {
                    ForEach(BookSortType.allCases, id: \.self) { sort in
                        Text(sort.rawValue.uppercased())
                            .tag(sort)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
            }
            .navigationTitle("Books")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                            .fontWeight(.semibold)
                    }
                    .tint(.systemRed)
                }
            }
        }
        .onAppear {
            viewModel.getBooks()
        }
    }
}

#Preview("BooksScreen") {
    BooksScreen()
}
