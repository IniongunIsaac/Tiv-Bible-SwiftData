//
//  TheLordsPrayerView.swift
//  TivBible
//
//  Created by Isaac Iniongun on 01/07/2023.
//

import SwiftUI
import AlertToast

struct TheLordsPrayerView: View {
    @EnvironmentObject private var preferenceStore: PreferenceStore
    @Environment(\.dismiss) private var dismiss
    private let actions: [VerseTapAction] = [.copy, .share]
    @State private var showToast = false
    @State private var toastMessage: ToastMessage = .empty
    
    var body: some View {
        VStack(spacing: 10) {
            Text(MiscItem.theLordsPrayer.rawValue.uppercased())
                .font(preferenceStore.font(size: 17))
                .fontWeight(.semibold)
            
            ScrollView {
                Text(Constants.TheLordsPrayer.title.uppercased())
                    .foregroundStyle(.secondary)
                    .font(preferenceStore.font(size: 15))
                    .padding(.bottom, 10)
                
                Text(Constants.TheLordsPrayer.content)
                    .font(preferenceStore.font(size: 15))
                
            }
            .scrollIndicators(.never)
            .padding(.bottom, 10)
            
            HStack(spacing: 20) {
                ForEach(actions, id: \.self) { action in
                    IconTextButton(title: action.rawValue, icon: action.iconName) {
                        didTapAction(action)
                    }
                }
            }
        }
        .padding()
        .overlay(alignment: .topTrailing) {
            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
            }
            .tint(.label)
            .offset(x: -20, y: 15)
        }
        .toast(isPresenting: $showToast, alert: {
            AlertToast(displayMode: .alert,
                       type: toastMessage.alertType,
                       subTitle: toastMessage.message)
        }, completion: {
            toastMessage = .empty
        })
        .onChange(of: toastMessage) { _, toastMessage in
            if toastMessage != .empty {
                showToast.toggle()
            }
        }
    }
    
    private func didTapAction(_ action: VerseTapAction) {
        let content = Constants.TheLordsPrayer.shareableText
        switch action {
        case .copy:
            content.copyToClipboard()
            toastMessage = .success("Copy success!")
        case .share:
            dismiss()
            runAfter(0.2) {
                content.share()
            }
        default:
            break
        }
    }
}

#Preview("TheLordsPrayerView") {
    TheLordsPrayerView()
        .environmentObject(PreferenceStore())
}
