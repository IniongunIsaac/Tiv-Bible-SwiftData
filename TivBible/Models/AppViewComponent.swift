//
//  AppViewComponent.swift
//  TivBible
//
//  Created by Isaac Iniongun on 01/01/2024.
//

import Foundation

enum AppViewComponent {
    case toolbar, verseTitle, normalText, bookNameNumber
    case searchBar, labelText
    
    var maxFontSize: CGFloat {
        switch self {
        case .toolbar:
            return currentDevice.isPhone ? 20 : 24
        case .verseTitle:
            return currentDevice.isPhone ? 16 : 20
        case .normalText:
            return currentDevice.isPhone ? 18 : 22
        case .bookNameNumber:
            return currentDevice.isPhone ? 20 : 24
        case .searchBar:
            return currentDevice.isPhone ? 16 : 20
        case .labelText:
            return currentDevice.isPhone ? 16 : 20
        }
    }
}
