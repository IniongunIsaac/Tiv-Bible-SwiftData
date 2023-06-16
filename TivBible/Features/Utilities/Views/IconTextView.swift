//
//  IconTextView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 16/06/2023.
//

import SwiftUI

struct IconTextView: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            Text(title)
            Image(systemName: icon)
        }
        .foregroundStyle(Color.label)
        .padding(4)
    }
}

#Preview("IconTextView") {
    IconTextView(title: "Share", icon: "square.and.arrow.up")
}
