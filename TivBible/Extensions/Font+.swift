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
                return "GentiumPlus"
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

/// https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-dynamic-type-with-a-custom-font
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: Double
    var maxSize: Double? = nil
    
    func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        var usableSize = scaledSize
        if let maxSize, scaledSize > maxSize.cgfloat {
            usableSize = maxSize.cgfloat
        }
        return content.font(.custom(name, size: usableSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(_ appFont: AppFont, size: Double, maxSize: Double? = nil) -> some View {
        return self.modifier(ScaledFont(name: appFont.rawValue, size: size, maxSize: maxSize))
    }
    
    func scaledFont(_ fontName: String, size: Double, maxSize: Double? = nil) -> some View {
        return self.modifier(ScaledFont(name: fontName, size: size, maxSize: maxSize))
    }
}
