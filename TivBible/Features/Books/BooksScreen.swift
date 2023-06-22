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
    @StateObject private var expansionHandler = DisclosureGroupExpansionHandler<String>()
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(viewModel.books) { book in
                        BookRowView(book: book, isExpanded: expansionHandler.isExpanded(book.name))
                            .onTapGesture {
                                withAnimation {
                                    expansionHandler.toggleExpanded(for: book.name)
                                }
                            }
                    }
                }
                
                Picker(selection: $preferenceStore.bookSortType, label: Text("")) {
                    ForEach(BookSortType.allCases, id: \.self) { sort in
                        Text(sort.rawValue.uppercased())
                            .tag(sort)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal)
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
            .interactiveDismissDisabled()
        }
        .onAppear {
            viewModel.getBooks()
        }
    }
}

//#Preview("BooksScreen") {
//    BooksScreen()
//}
