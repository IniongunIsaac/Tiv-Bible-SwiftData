//
//  MultiSelectionActionsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import SwiftUI

struct VerseTapActionsView: View {
    let viewModel: ReaderViewModel
    @Binding var showNotes: Bool
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text(viewModel.selectedVersesText.uppercased())
                .font(preferenceStore.font(size: 15))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.trailing, 30)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing: 10) {
                    ForEach(VerseTapAction.allCases, id: \.self) { action in
                        IconTextButton(title: action.rawValue.uppercased(), icon: action.iconName) {
                            
                            viewModel.didTapVerseAction(action)
                            
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
                        withAnimation {
                            viewModel.removeHighlights()
                        }
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
                    .tint(.label)
                    
                    ForEach(ColorHex.allCases, id: \.self) { color in
                        Button {
                            withAnimation {
                                viewModel.setHighlights(color)
                            }
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
        .frame(height: 220)
        .scrollIndicators(.never)
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation {
                    viewModel.unselectedVerses()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
            }
            .tint(.label)
            .offset(x: -15, y: 15)
        }
    }
}

//#Preview("VerseTapActionsView") {
//    VerseTapActionsView(viewModel: ReaderViewModel(),
//                        showNotes: .constant(false))
//    .environmentObject(PreferenceStore())
//    .previewLayout(.sizeThatFits)
//}
