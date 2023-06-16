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
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.verses) { verse in
                    Text(verse.attrText)
                }
                .scrollIndicators(.never)
                .listRowSpacing(-10)
                .listStyle(.plain)
                .padding(0)
            }
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

/*#Preview {
    ReaderScreen()
}*/
