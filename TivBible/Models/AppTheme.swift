//
//  AppTheme.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import SwiftUI

enum AppTheme: String, CaseIterable {
    case system
    case light
    case dark
    
    var colorScheme: ColorScheme {
        switch self {
        case .system:
            return .dark
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
