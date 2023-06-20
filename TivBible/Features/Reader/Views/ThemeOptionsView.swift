//
//  ThemeOptionsView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct ThemeOptionsView: View {
    @State private var selectedTheme: ThemeOption = .system
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("THEME:")
                .font(.footnote)
                .foregroundStyle(.secondary)
            
            Picker(selection: $selectedTheme, label: Text("")) {
                ForEach(ThemeOption.allCases, id: \.self) { option in
                    Text(option.rawValue.uppercased())
                        .tag(option)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    ThemeOptionsView()
        .padding()
}
