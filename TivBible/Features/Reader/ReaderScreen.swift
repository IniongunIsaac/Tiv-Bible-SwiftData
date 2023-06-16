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
    
    var body: some View {
        NavigationView {
            List(viewModel.verses) { verse in
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
