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
    @Environment(\.colorScheme) private var systemColorScheme
    
    private var colorScheme: ColorScheme {
        switch preferenceStore.appTheme {
        case .system:
            return systemColorScheme
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 30) {
                Text("STYLES")
                    .font(preferenceStore.font(size: 16))
                    .padding(.top)
                
                FontSizeView()
                
                LineSpacingView()
                
                FontStyleButton()
                
                AppThemesView()
                
                Toggle(isOn: $preferenceStore.stayAwake) {
                    Text("STAY AWAKE:")
                        .font(preferenceStore.font(size: 14, viewComponent: .labelText))
                        .foregroundStyle(.secondary)
                }
                .padding(.trailing, 2)
                
                Spacer()
            }
        }
        .preferredColorScheme(colorScheme)
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
            .offset(x: -18, y: 12)
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
