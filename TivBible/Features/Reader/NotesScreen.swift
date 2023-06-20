//
//  NotesScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 19/06/2023.
//

import SwiftUI

struct NotesScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: ReaderViewModel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notesTokens) { token in
                    HStack {
                        RoundedRectangle(cornerRadius: 6)
                            .frame(width: 5)
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(token.text)
                            Text(token.reference)
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer(minLength: 5)
                }
                
                TextEditor(text: $viewModel.versesNotes)
                    .frame(minHeight: 200)
                    .overlay(alignment: .topLeading) {
                        viewModel.versesNotes.isEmpty ?
                        Text("What would you like to say?")
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
                            .fontWeight(.semibold)
                    }
                    .tint(.systemRed)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveNotes()
                    } label: {
                        Text("Save")
                            .font(.callout)
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

#Preview {
    NotesScreen(viewModel: ReaderViewModel())
}
