//
//  MiscItemActionsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 27/06/2023.
//

import SwiftUI

struct MiscItemActionsView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    var body: some View {
        List {
            Text("Choose Action")
                .font(preferenceStore.font(size: 17))
                .fontWeight(.semibold)
                .centerHorizontally()
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            ForEach(MiscItemAction.allCases, id: \.self) { item in
                MiscItemButton(title: item.rawValue, iconName: item.iconName) {
                    
                }
                .background(item == .delete ? .red : .secondarySystemBackground)
                .cornerRadius(10)
                .listRowSeparator(.hidden)
            }
        }
        .scrollIndicators(.never)
        .listStyle(.plain)
        .overlay(alignment: .topTrailing) {
            Button {
                
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            .tint(.label)
            .offset(x: -20, y: 20)
        }
    }
}

//#Preview {
//    MiscItemActionsView()
//}
