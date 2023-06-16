//
//  ReaderScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI
import SwiftData

struct ReaderScreen: View {
    
    private var viewModel = ReaderViewModel()
    @State private var selected = false
    @State private var selectedVerse: Verse?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List(viewModel.verses, id: \.id) { verse in
                    Text(verse.attrText)
                        .showUnderline(verse.isSelected)
                        .onTapGesture {
                            withAnimation {
                                verse.isSelected.toggle()
                                viewModel.refreshVerses()
                            }
                        }
                }
                .scrollIndicators(.never)
                .listRowSpacing(-10)
                .listStyle(.plain)
                
                MultiSelectionActionsView()
                    .visible(viewModel.showVerseSelectionActions)
            }
            //.padding(.bottom, -20)
            .onAppear {
                viewModel.getVerses()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("choose book")
                    } label: {
                        Text(viewModel.bookNameAndChapterNumber)
                            .foregroundStyle(Color.label)
                            .font(.gentiumPlus(.bold, size: 12))
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        Button {
                            
                        } label: {
                            Image(systemName: "textformat.size")
                        }
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    .foregroundStyle(Color.label)
                    .font(.gentiumPlus(.regular, size: 14))
                }
            }
        }
        
    }
}

#Preview("ReaderScreen") {
    ReaderScreen()
}
