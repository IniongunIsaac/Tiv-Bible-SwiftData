//
//  NotesScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import SwiftUI
import SwiftData
import AlertToast

struct NotesScreen: View {
    private let viewModel = NotesViewModel()
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var showConfirmationAlert = false
    @State private var showNoteDetails = false
    @State private var note: Note?
    @State private var showActions = false
    @State private var showToast = false
    @State private var toastMessage: ToastMessage = .empty
    private var shareText: String {
        note?.shareText ?? ""
    }
    
    @Query(sort: \.takenOn, order: .reverse)
    private var notes: [Note]
    
    var body: some View {
        ZStack {
            if notes.isNotEmpty {
                List(notes) { note in
                    NoteCommentView(note: note, lines: 3, commentLines: 3) { action in
                        self.note = note
                        if action == .details {
                            showNoteDetails.toggle()
                        } else {
                            didTapNoteAction(action)
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .padding(.bottom, 20)
                }
                .scrollIndicators(.never)
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
                
            } else {
                EmptyStateView(message: "You have no notes")
            }
        }
        .navigationTitle("Notes")
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
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showConfirmationAlert.toggle()
                } label: {
                    Text("Clear All")
                        .font(preferenceStore.font())
                        .foregroundStyle(Color.systemRed)
                }
                .disabled(notes.isEmpty)
            }
        }
        .alert(isPresented: $showConfirmationAlert) {
            Alert(
                title: Text("Confirmation"),
                message: Text("Are you sure you want to proceed?"),
                primaryButton: .default(Text("Yes"), action: {
                    deleteNotes()
                }),
                secondaryButton: .cancel()
            )
        }
        .navigationDestination(isPresented: $showNoteDetails) {
            if let note {
                NoteDetailsView(note: note)
            } else {
                EmptyView()
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
    
    private func deleteNotes() {
        for note in notes {
            context.delete(note)
        }
    }
    
    private func deleteNote() {
        guard let note else { return }
        context.delete(note)
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
        shareText.copyToClipboard()
        toastMessage = .success("Copy success!")
    }
    
    private func shareNote() {
        runAfter {
            shareText.share()
        }
    }
    
    private func didChooseMiscItemAction(_ itemAction: MiscItemAction) {
        switch itemAction {
        case .readFullChapter:
            guard let chapterId = note?.verses.first?.chapter?.id else { return }
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
