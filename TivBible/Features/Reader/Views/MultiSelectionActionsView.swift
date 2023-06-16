//
//  MultiSelectionActionsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import SwiftUI

struct MultiSelectionActionsView: View {
    var body: some View {
        VStack(alignment: .center) {
            
            Text("Genese 11:1-25; 8:15-24")
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.trailing, 30)
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing:10) {
                    ForEach(VerseSelectionAction.allCases, id: \.self) { action in
                        IconTextButton(title: action.rawValue, icon: action.iconName)
                    }
                }
            }
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: [GridItem(.flexible())], spacing:10) {
                    ForEach(0 ..< 10) { item in
                        Circle().fill(.blue)
                            .frame(width: 50, height: 50)
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
    MultiSelectionActionsView()
        .previewLayout(.sizeThatFits)
}
