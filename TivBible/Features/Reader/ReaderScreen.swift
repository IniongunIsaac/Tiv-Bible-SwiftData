//
//  ReaderScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI
import SwiftData
import AlertToast

struct ReaderScreen: View {
    
    @Provided private var viewModel: ReaderViewModel
    @StateObject private var preferenceStore = PreferenceStore()
    @State private var showToast = false
    @State private var showNotes = false
    @State private var showStyles = false
    @State private var showBooks = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List(viewModel.verses, id: \.id) { verse in
                    if verse.title.isNotEmpty {
                        Text(verse.title.uppercased())
                            .foregroundStyle(.secondary)
                            .font(.custom(preferenceStore.appFont.rawValue, size: 14))
                            .fontWeight(.semibold)
                    }
                    
                    Text(verse.attrText(fontSize: preferenceStore.fontSize,
                                        fontName: preferenceStore.appFont.rawValue))
                        .lineSpacing(preferenceStore.lineSpacing.value)
                        .showUnderline(verse.isSelected)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            withAnimation(.spring) {
                                verse.isSelected.toggle()
                                viewModel.refreshVerses()
                            }
                        }
                }
                .scrollIndicators(.never)
                .listRowSpacing(-10)
                .listStyle(.plain)
                
                VerseTapActionsView(viewModel: viewModel, showNotes: $showNotes)
                    .transition(.scale)
                    .visible(viewModel.showVerseSelectionActions)
            }
            .padding(.bottom, -20)
            .onAppear {
                viewModel.getVerses()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showBooks.toggle()
                    } label: {
                        Text(viewModel.bookNameAndChapterNumber)
                            .foregroundStyle(Color.label)
                            .font(.custom(preferenceStore.appFont.rawValue, size: 14))
                            .fontWeight(.semibold)
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 0) {
                        Button {
                            showStyles.toggle()
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
            .toast(isPresenting: $showToast, alert: {
                AlertToast(displayMode: .alert,
                           type: .complete(.systemGreen),
                           subTitle: viewModel.toastMessage)
            }, completion: {
                viewModel.toastMessage = ""
            })
            .sheet(isPresented: $showNotes) {
                NotesScreen(viewModel: viewModel)
            }
            .sheet(isPresented: $showStyles) {
                StylesView(showStyles: $showStyles)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showBooks) {
                BooksScreen()
            }
            .onChange(of: viewModel.toastMessage) {
                if viewModel.toastMessage.isNotEmpty {
                    showToast.toggle()
                }
            }
        }
        
    }
}

#Preview("ReaderScreen") {
    ReaderScreen()
}
