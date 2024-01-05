//
//  AppFont.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import Foundation

enum AppFont: String, CaseIterable {
    case system
    case gentiumPlus = "GentiumPlus"
    case poppins = "Poppins-Regular"
    case newYork = "NewYorkLarge-Regular"
    case lato = "Lato-Regular"
    case georgia = "Georgia"
    case baskerville = "Baskerville"
    case avenirNext = "AvenirNext-Regular"
    case avenirBook = "Avenir-Book"
    
    var displayName: String {
        switch self {
        case .system:
            return "System"
        case .gentiumPlus:
            return "Gentium Plus"
        case .poppins:
            return "Poppins"
        case .newYork:
            return "New York"
        case .lato:
            return "Lato"
        case .georgia:
            return "Georgia"
        case .baskerville:
            return "Baskerville"
        case .avenirNext:
            return "Avenir Next"
        case .avenirBook:
            return "Avenir Book"
        }
    }
}
