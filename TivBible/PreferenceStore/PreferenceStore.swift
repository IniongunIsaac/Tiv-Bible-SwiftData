//
//  PreferenceStore.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftUI

final class PreferenceStore: ObservableObject {
    @AppStorage(.hasSetupDB) var hasSetupDB: Bool = false
    @AppStorage(.currentChapterUUID) var currentChapterUUID: String = ""
    @AppStorage(.fontSize) var fontSize: Double = Constants.FontSize.default
    @AppStorage("lineSpacing") var lineSpacing: LineSpacingType = .normal
    @AppStorage("appTheme") var appTheme: AppTheme = .system
    @AppStorage("appFont") var appFont: AppFont = .gentiumPlus
    @AppStorage("bookSortType") var bookSortType: BookSortType = .traditional
    @AppStorage(.stayAwake) var stayAwake: Bool = false
    @AppStorage("selectedTabItem") var selectedTabItem: TabItem = .read
    
    func updateFontSize(type: FontSizeButtonType) {
        switch type {
        case .increment:
            if fontSize < Constants.FontSize.max {
                fontSize += 1
            }
        case .decrement:
            if fontSize > Constants.FontSize.min {
                fontSize -= 1
            }
        }
    }
    
    func updateLineSpacing(_ spacing: LineSpacingType) {
        lineSpacing = spacing
    }
    
    func font(size: Double? = nil, viewComponent: AppViewComponent = .normalText) -> Font {
        /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font
        @Environment(\.sizeCategory) var sizeCategory
        let scaledSize = UIFontMetrics.default.scaledValue(for: size ?? fontSize)
        let maxFontSize = viewComponent.maxFontSize
        let usableSize = scaledSize > maxFontSize ? (size ?? maxFontSize) : scaledSize
        
        if appFont == .system {
            return .system(size: usableSize, design: .rounded)
        } else {
            return .custom(appFont.rawValue, size: usableSize)
        }
    }
    
    func updateNavFont() {
        let fontName = "\(appFont.rawValue)-Bold"
        UINavigationBar.appearance().titleTextAttributes = [
            .font: UIFont(name: fontName, size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        ]
    }
    
    func updateLargeNavFont() {
        let fontName = "\(appFont.rawValue)-Black"
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .font: UIFont(name: fontName, size: 30) ?? UIFont.boldSystemFont(ofSize: 30)
        ]
    }
}
