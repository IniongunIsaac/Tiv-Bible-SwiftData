//
//  NoteCommentView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 29/06/2023.
//

import SwiftUI

enum NoteCommentAction: Int {
    case details
    case copy
    case share
    case more
}

struct NoteCommentView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var note: Note
    var lines: Int? = nil
    var commentLines: Int? = nil
    var action: ArgumentAction<NoteCommentAction>? = nil
    
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                Group {
                    NoteView(text: note.verses.shareableText,
                             reference: note.reference,
                             date: note.takenOn.dateString,
                             lines: lines)
                    
                    HStack {
                        Text(note.comment)
                            .font(preferenceStore.font())
                            .lineLimit(commentLines)
                            .padding()
                        
                        Spacer()
                    }
                    .background(Color.gray.opacity(0.2).clipShape(.rect(cornerRadius: 3, style: .circular)))
                }
                .onTapGesture {
                    withAnimation {
                        action?(.details)
                    }
                }
                
                HStack(spacing: 15) {
                    IconOnlyButton(iconName: "doc") {
                        action?(.copy)
                    }
                    
                    IconOnlyButton(iconName: "square.and.arrow.up") {
                        action?(.share)
                    }
                    
                    Spacer()
                    
                    IconOnlyButton(iconName: "ellipsis") {
                        action?(.more)
                    }
                }
            }
            .padding()
        }
        .background(.ultraThinMaterial)
    }
}
