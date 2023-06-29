//
//  NotesScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import SwiftUI
import SwiftData

struct NotesScreen: View {
    private let viewModel = NotesViewModel()
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.dismiss) private var dismiss
    @State private var showConfirmationAlert = false
    
    @Query(sort: \.takenOn, order: .reverse)
    private var notes: [Note]
    
    var body: some View {
        ZStack {
            if notes.isNotEmpty {
                List(notes) { note in
                    VStack {
                        VStack(spacing: 10) {
                            NoteView(text: note.verses.shareableText,
                                     reference: note.reference,
                                     date: note.takenOn.formatted(),
                                     lines: 3)
                            
                            HStack {
                                Text(note.comment)
                                    .font(preferenceStore.font())
                                    .padding()
                                
                                Spacer()
                            }
                            .background(Color.gray.opacity(0.2))
                        }
                        .padding()
                    }
                    .background(.ultraThinMaterial)
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
                    //viewModel.clear()
                }),
                secondaryButton: .cancel()
            )
        }
    }
}

//#Preview {
//    NotesScreen()
//}
