//
//  NoteDetailsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 29/06/2023.
//

import SwiftUI
import AlertToast

struct NoteDetailsView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    var note: Note
    @State private var showActions = false
    @State private var showToast = false
    @State private var toastMessage: ToastMessage = .empty
    
    var body: some View {
        ScrollView {
            NoteCommentView(note: note) { action in
                didTapNoteAction(action)
            }
        }
        .scrollIndicators(.never)
        .navigationTitle("Note")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                }
                .tint(.label)
            }
        }
        .sheet(isPresented: $showActions) {
            MiscItemActionsView(showActions: $showActions) { itemAction in
                didChooseMiscItemAction(itemAction)
            }
            .presentationDetents([.height(370)])
        }
        .toast(isPresenting: $showToast, alert: {
            AlertToast(displayMode: .alert,
                       type: toastMessage.alertType,
                       subTitle: toastMessage.message)
        }, completion: {
            toastMessage = .empty
        })
        .onChange(of: toastMessage) { _, toastMessage in
            if toastMessage != .empty {
                showToast.toggle()
            }
        }
    }
    
    private func deleteNote() {
        context.delete(note)
        dismiss()
    }
    
    private func didTapNoteAction(_ noteAction: NoteCommentAction) {
        switch noteAction {
        case .details:()
        case .copy:
            copyNote()
            
        case .share:
            shareNote()
            
        case .more:
            showActions.toggle()
        }
    }
    
    private func copyNote() {
        note.shareText.copyToClipboard()
        toastMessage = .success("Copy success!")
    }
    
    private func shareNote() {
        note.shareText.share()
    }
    
    private func didChooseMiscItemAction(_ itemAction: MiscItemAction) {
        switch itemAction {
        case .readFullChapter:
            guard let chapterId = note.verses.first?.chapter?.id else { return }
            preferenceStore.currentChapterUUID = chapterId
            preferenceStore.selectedTabItem = .read
            dismiss()
            
        case .share:
            shareNote()
            
        case .copy:
            copyNote()
            
        case .delete:
            deleteNote()
        }
    }
}
