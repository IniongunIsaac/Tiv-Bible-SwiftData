//
//  SettingsScreen.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import SwiftUI
import UIKit

struct SettingsScreen: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 40) {
                VStack {
                    Image(.appLogo)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 70, height: 70)
                    
                    Text("v3.0")
                        .font(preferenceStore.font(size: 14))
                        .foregroundStyle(.secondary)
                }
                
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
        }
        .padding()
        .onChange(of: preferenceStore.stayAwake) { _, awake in
            withAnimation {
                UIApplication.shared.isIdleTimerDisabled = awake
            }
        }
    }
}

#Preview {
    SettingsScreen()
        .environmentObject(PreferenceStore())
}
