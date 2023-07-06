//
//  StylesView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

struct StylesView: View {
    @Binding var showStyles: Bool
    @StateObject private var preferenceStore = PreferenceStore()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("STYLES")
                .offset(y: -28)
                .font(preferenceStore.font(size: 16))
            
            FontSizeView()
            
            LineSpacingView()
            
            FontStyleButton()
            
            AppThemesView()
            
            Toggle(isOn: $preferenceStore.stayAwake) {
                Text("STAY AWAKE:")
                    .font(preferenceStore.font(size: 14))
                    .foregroundStyle(.secondary)
            }
            .padding(.trailing, 2)
        }
        .preferredColorScheme(preferenceStore.appTheme.colorScheme)
        .padding(.horizontal)
        .overlay(alignment: .topTrailing) {
            Button {
                showStyles.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
            }
            .tint(.label)
            .offset(x: -18, y: -30)
        }
        .onChange(of: preferenceStore.stayAwake) { _, awake in
            withAnimation {
                UIApplication.shared.isIdleTimerDisabled = awake
            }
        }
    }
}

//#Preview("StylesView") {
//    StylesView(showStyles: .constant(false))
//        .background(.ultraThinMaterial)
//        .previewLayout(.sizeThatFits)
//}
