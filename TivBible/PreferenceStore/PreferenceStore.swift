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
    
    func font(size: Double? = nil) -> Font {
        if appFont == .system {
            return .system(size: size ?? fontSize, design: .rounded)
        } else {
            /// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font
            @Environment(\.sizeCategory) var sizeCategory
            let scaledSize = UIFontMetrics.default.scaledValue(for: size ?? fontSize)
            return .custom(appFont.rawValue, size: scaledSize)
        }
    }
}
