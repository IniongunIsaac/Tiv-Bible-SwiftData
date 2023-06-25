//
//  BookmarksScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 25/06/2023.
//

import SwiftUI
import SwiftData

struct BookmarksScreen: View {
    private var viewModel = BookmarksViewModel()
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    //TODO: See if we can write this code in this manner instead of going with what we have in the VM ATM
    /*@Environment(\.modelContext) private var context
    private let predicate = #Predicate<Verse> {
        $0.isBookmarked
    }
    @Query(filter: #Predicate<Verse>(\.isBookmarked),
           sort: \.bookmarkDate,
           order: .forward)
    private var bookmarks: [Verse]*/
    
    var body: some View {
        List(viewModel.bookmarks) { bookmark in
            HStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 5)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(bookmark.text)
                        .font(preferenceStore.font(size: 16))
                    
                    HStack {
                        Text(bookmark.reference)
                            .font(preferenceStore.font(size: 15))
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(bookmark.bookmarkDate ?? Date(), style: .date)
                            .font(preferenceStore.font(size: 15))
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
            }
            .padding(.bottom, 15)
            .onTapGesture {
                withAnimation {
                    //preferenceStore.currentChapterUUID = verse.chapter?.id ?? ""
                    //verseNumber = verse.number
                    //shouldDismiss.toggle()
                }
            }
        }
        .scrollIndicators(.never)
        .listStyle(.plain)
        .navigationTitle("Bookmarks")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.getBookmakrs()
        }
    }
}

//#Preview {
//    BookmarksScreen()
//}
