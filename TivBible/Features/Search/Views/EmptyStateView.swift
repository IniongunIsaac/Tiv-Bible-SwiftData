//
//  EmptyStateView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 23/06/2023.
//

import SwiftUI

struct EmptyStateView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    var body: some View {
        VStack {
            Image(systemName: "hourglass.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .fontWeight(.thin)
            
            Text("Results will appear here")
                .font(preferenceStore.font(size: 16))
        }
    }
}

#Preview {
    EmptyStateView()
        .environmentObject(PreferenceStore())
}
