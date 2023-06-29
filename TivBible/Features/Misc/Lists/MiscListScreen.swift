//
//  MiscListScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import SwiftUI
import AlertToast

struct MiscListScreen: View {
    private var viewModel = MiscListViewModel()
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.dismiss) private var dismiss
    @State private var showActions = false
    @State private var showToast = false
    @State private var showConfirmationAlert = false
    @State private var selectedVerse: Verse? = nil
    var miscItem: MiscItem
    
    init(miscItem: MiscItem) {
        self.miscItem = miscItem
    }
    
    var body: some View {
        ZStack {
            if viewModel.verses.isNotEmpty {
                List(viewModel.verses) { verse in
                    NoteView(text: verse.text,
                             reference: verse.reference,
                             date: (verse.bookmarkDate ?? Date()).dateString,
                             barColor: viewModel.fillColor(for: verse))
                    .listRowSeparator(.hidden)
                    .padding(.bottom, 15)
                    .onTapGesture {
                        withAnimation {
                            selectedVerse = verse
                            showActions.toggle()
                        }
                    }
                }
                .scrollIndicators(.never)
                .listStyle(.plain)
            } else {
                EmptyStateView(message: "You have no \(miscItem.rawValue.lowercased())")
            }
        }
        .navigationTitle(miscItem.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.miscItem = miscItem
            viewModel.getVerses()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .tint(.label)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showConfirmationAlert.toggle()
                } label: {
                    Text("Clear All")
                        .font(preferenceStore.font())
                        .foregroundStyle(Color.systemRed)
                }
                .disabled(viewModel.verses.isEmpty)
            }
        }
        .sheet(isPresented: $showActions) {
            MiscItemActionsView(showActions: $showActions) { itemAction in
                didChooseMiscItemAction(itemAction)
            }
            .presentationDetents([.height(370)])
        }
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Confirmation"),
                message: Text("Are you sure you want to proceed?"),
                primaryButton: .default(Text("Yes"), action: {
                    viewModel.clear()
                }),
                secondaryButton: .cancel()
            )
        }
        .toast(isPresenting: $showToast, alert: {
            AlertToast(displayMode: .alert,
                       type: viewModel.toastMessage.alertType,
                       subTitle: viewModel.toastMessage.message)
        }, completion: {
            viewModel.toastMessage = .empty
        })
        .onChange(of: viewModel.toastMessage) { _, toastMessage in
            if toastMessage != .empty {
                showToast.toggle()
            }
        }
        
    }
    
    private func didChooseMiscItemAction(_ itemAction: MiscItemAction) {
        switch itemAction {
        case .readFullChapter:
            guard let chapterId = selectedVerse?.chapter?.id else { return }
            preferenceStore.currentChapterUUID = chapterId
            preferenceStore.selectedTabItem = .read
            dismiss()
            
        case .share:
            guard let selectedVerse else { return }
            selectedVerse.shareableText.share()
            
        case .copy:
            guard let selectedVerse else { return }
            selectedVerse.shareableText.copyToClipboard()
            viewModel.toastMessage = .success("Copy success")
            
        case .delete:
            viewModel.delete(selectedVerse)
        }
    }
}
