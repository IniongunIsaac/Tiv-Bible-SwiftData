//
//  AppFont.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import Foundation

enum AppFont: String, CaseIterable {
    case System
    case GentiumPlus
    case Poppins = "Poppins-Regular"
    case NewYork = "NewYorkLarge-Regular"
    case Lato = "Lato-Regular"
    case Georgia
    case Baskerville
    case AvenirNext = "AvenirNext-Regular"
    case AvenirBook = "Avenir-Book"
    
    var displayName: String {
        switch self {
        case .System:
            return "System"
        case .GentiumPlus:
            return "Gentium"
        case .Poppins:
            return "Poppins"
        case .NewYork:
            return "New York"
        case .Lato:
            return "Lato"
        case .Georgia:
            return "Georgia"
        case .Baskerville:
            return "Baskerville"
        case .AvenirNext:
            return "Avenir Next"
        case .AvenirBook:
            return "Avenir Book"
        }
    }
}
