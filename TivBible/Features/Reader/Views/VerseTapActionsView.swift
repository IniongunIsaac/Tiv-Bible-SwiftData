//
//  MultiSelectionActionsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import SwiftUI

struct VerseTapActionsView: View {
    let viewModel: ReaderViewModel
    @Binding var showToast: Bool
    @Binding var showNotes: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text(viewModel.selectedVersesText)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.trailing, 30)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(VerseTapAction.allCases, id: \.self) { action in
                        IconTextButton(title: action.rawValue, icon: action.iconName) {
                            viewModel.didTapVerseAction(action)
                            if [.copy, .bookmark].contains(action) {
                                showToast.toggle()
                            }
                            if action == .takeNotes {
                                showNotes.toggle()
                            }
                        }
                    }
                }
            }
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    Button {
                        viewModel.removeHighlights()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .tint(.label)
                    
                    ForEach(ColorHex.allCases, id: \.self) { color in
                        Button {
                            viewModel.setHighlights(color)
                        } label: {
                            Circle().fill(color.color)
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15, corners: [.topLeft, .topRight])
        .frame(height: 250)
        .scrollIndicators(.never)
        .overlay(alignment: .topTrailing) {
            Button {
                viewModel.unselectedVerses()
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
            }
            .tint(.label)
            .offset(x: -15, y: 40)
        }
    }
}

#Preview("MultiSelectionActionsView") {
    VerseTapActionsView(viewModel: ReaderViewModel(),
                        showToast: .constant(false),
                        showNotes: .constant(false))
    .previewLayout(.sizeThatFits)
}
