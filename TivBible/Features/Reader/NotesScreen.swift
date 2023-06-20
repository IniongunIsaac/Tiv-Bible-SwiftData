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
            ScrollView {
                ForEach(viewModel.notesTokens) { token in
                    HStack() {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 6)
                        
                        VStack(alignment: .leading) {
                            Text(token.text)
                            Text(token.reference)
                                .font(.footnote)
                                .fontWeight(.bold)
                        }
                        
                        Spacer()
                    }
                    Spacer(minLength: 20)
                }
                
                Spacer(minLength: 30)
                
                TextEditor(text: $viewModel.notesText)
                    .frame(minHeight: 200)
                    .overlay(alignment: .topLeading) {
                        viewModel.notesText.isEmpty ?
                        Text("What would you like to say?")
                            .foregroundColor(.systemGray)
                            .offset(y: 10)
                        : nil
                    }
                    .textCase(nil)
                
            }
            .padding()
            .navigationTitle("Notes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Text("Dismiss")
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
                    .disabled(viewModel.notesText.isEmpty)
                    .buttonBorderShape(.capsule)
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    NotesScreen(viewModel: ReaderViewModel())
}

//God is good all the time!
