//
//  ReaderScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI
import SwiftData
import AlertToast
import IsScrolling

struct ReaderScreen: View {
    
    @Provided private var viewModel: ReaderViewModel
    @StateObject private var preferenceStore = PreferenceStore()
    @State private var showToast = false
    @State private var showNotes = false
    @State private var showStyles = false
    @State private var showBooks = false
    @State private var showErrorToast = false
    @State private var isScrolling = false
    @State private var showSearch = false
    @State private var verseNumber: Int?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
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
                            .id(verse.number)
                            .background(verseNumber == verse.number ? Color(hex: "#FFAF02") : Color.clear)
                    }
                    .scrollStatusMonitor($isScrolling, monitorMode: .exclusion)
                    .scrollIndicators(.never)
                    .listRowSpacing(-10)
                    .listStyle(.plain)
                    .onChange(of: verseNumber) { _, number in
                        if let number {
                            withAnimation {
                                proxy.scrollTo(number, anchor: .top)
                            }
                        }
                    }
                }
                
                VerseTapActionsView(viewModel: viewModel, showNotes: $showNotes)
                    .transition(.scale)
                    .visible(viewModel.showVerseSelectionActions)
            }
            .overlay(alignment: .bottomLeading) {
                NextButton(type: .previous) {
                    withAnimation {
                        viewModel.getNextOrPreviousChapterVerses(type: .previous)
                    }
                }
                .transition(.scale)
                .visible(!viewModel.showVerseSelectionActions || isScrolling)
            }
            .overlay(alignment: .bottomTrailing) {
                NextButton(type: .next) {
                    withAnimation {
                        viewModel.getNextOrPreviousChapterVerses(type: .next)
                    }
                }
                .transition(.scale)
                .visible(!viewModel.showVerseSelectionActions || isScrolling)
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
                            .font(preferenceStore.font(size: 14))
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
                            showSearch.toggle()
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
            .toast(isPresenting: $showErrorToast, alert: {
                AlertToast(displayMode: .hud,
                           type: .error(.systemRed),
                           subTitle: viewModel.errorMessage)
            }, completion: {
                viewModel.errorMessage = ""
            })
            .sheet(isPresented: $showNotes) {
                TakeNotesScreen(viewModel: viewModel)
            }
            .sheet(isPresented: $showStyles) {
                StylesView(showStyles: $showStyles)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showBooks) {
                BooksScreen()
            }
            .fullScreenCover(isPresented: $showSearch) {
                SearchScreen(verseNumber: $verseNumber)
            }
            .onChange(of: viewModel.toastMessage) {
                if viewModel.toastMessage.isNotEmpty {
                    showToast.toggle()
                }
            }
            .onChange(of: viewModel.errorMessage) {
                if viewModel.errorMessage.isNotEmpty {
                    showErrorToast.toggle()
                }
            }
            .onChange(of: preferenceStore.currentChapterUUID) {
                viewModel.getVerses()
            }
        }
        
    }
}

//#Preview("ReaderScreen") {
//    ReaderScreen()
//}
