//
//  ColorHex.swift
//  TivBible
//
//  Created by Isaac Iniongun on 19/06/2023.
//

import Foundation
import SwiftUI

enum ColorHex: String, CaseIterable {
    case _1 = "#FF8A65"
    case _2 = "#FFB74D"
    case _3 = "#FFD54F"
    case _4 = "#DCE775"
    case _5 = "#2962FF"
    case _6 = "#4DB6AC"
    case _7 = "#00B8D4"
    case _8 = "#00BFA5"
    case _9 = "#00C853"
    case _10 = "#64DD17"
    case _11 = "#AEEA00"
    case _12 = "#FFD600"
    case _13 = "#FFAB00"
    case _14 = "#FF6D00"
    case _15 = "#DD2C00"
    case _16 = "#E57373"
    case _17 = "#F06292"
    case _18 = "#BA68C8"
    case _19 = "#7986CB"
    case _20 = "#4FC3F7"
    
    var color: Color {
        rawValue.color
    }
}
