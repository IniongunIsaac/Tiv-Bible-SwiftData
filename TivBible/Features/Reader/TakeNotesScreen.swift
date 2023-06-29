//
//  TakeNotesScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 19/06/2023.
//

import SwiftUI

struct TakeNotesScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Bindable var viewModel: ReaderViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notesTokens) { token in
                    NoteView(text: token.text, reference: token.reference)
                    
                    Spacer(minLength: 5)
                }
                
                TextEditor(text: $viewModel.versesNotes)
                    .font(preferenceStore.font())
                    .frame(minHeight: 200)
                    .overlay(alignment: .topLeading) {
                        viewModel.versesNotes.isEmpty ?
                        Text("What would you like to say?")
                            .font(preferenceStore.font())
                            .foregroundColor(.systemGray)
                            .offset(x: 6, y: 10)
                        : nil
                    }
                    .textCase(nil)
                    .listRowSeparator(.hidden)
                
            }
            .scrollIndicators(.never)
            .listStyle(.plain)
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                            .font(preferenceStore.font(size: 14))
                            .fontWeight(.semibold)
                    }
                    .tint(.systemRed)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveNotes()
                    } label: {
                        Text("Save")
                            .font(preferenceStore.font(size: 14))
                            .padding(.horizontal, 4)
                            .padding(.vertical, 2)
                    }
                    .disabled(viewModel.versesNotes.isEmpty)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                }
            }
            .onChange(of: viewModel.notesTokens) {
                if viewModel.notesTokens.isEmpty {
                    dismiss()
                }
            }
        }
    }
}

#Preview("TakeNotesScreen") {
    TakeNotesScreen(viewModel: ReaderViewModel())
        .environmentObject(PreferenceStore())
}
