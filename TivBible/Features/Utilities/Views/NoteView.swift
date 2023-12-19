//
//  NoteView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 28/06/2023.
//

import SwiftUI

struct NoteView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    var text: String
    var reference: String
    var date: String = ""
    var barColor: Color = .label
    var lines: Int? = nil
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 6)
                .fill(barColor)
                .frame(width: 5)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(text)
                    .font(preferenceStore.font())
                    .lineLimit(lines)
                
                HStack {
                    Text(reference)
                        .font(preferenceStore.font(size: 14))
                        .fontWeight(.bold)
                    
                    if date.isNotEmpty {
                        Spacer()
                        
                        Text(date)
                            .font(preferenceStore.font(size: 14))
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

#Preview("NoteView") {
    NoteView(
        text: "Genese 3: v2. Tsô kwase la gema kaa a iyô la er: Atam a ikon i ken sule ne yô, i rumun er se̱ ya, v3. kpa atam a kon u u lu hen atô sule la yô, Aôndo kaa er: De ye nen ga, ave tsô kpaa, de benden nen sha min ga, sha er né kpe ga yô",
        reference: "Genese 12:22-45",
        date: "",
        barColor: Color(uiColor: UIColor.systemBlue)
    )
    .environmentObject(PreferenceStore())
    .padding()
    .previewLayout(.sizeThatFits)
    .frame(height: 180)
}
