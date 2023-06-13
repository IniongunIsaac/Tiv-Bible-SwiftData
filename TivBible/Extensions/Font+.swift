//
//  Font+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftUI

extension Font {
    enum GentiumPlus {
        case regular
        case bold
        case italic
        case boldItalic
        case custom(String)
        
        var value: String {
            switch self {
            case .custom(let name):
                return name
            case .regular:
                return "GentiumPlus-Regular"
            case .bold:
                return "GentiumPlus-Bold"
            case .italic:
                return "GentiumPlus-Italic"
            case .boldItalic:
                return "GentiumPlus-BoldItalic"
            }
        }
    }
    
    static func gentiumPlus(_ type: GentiumPlus, size: CGFloat = 16) -> Font {
        .custom(type.value, size: size)
    }
}
