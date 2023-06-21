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
}
