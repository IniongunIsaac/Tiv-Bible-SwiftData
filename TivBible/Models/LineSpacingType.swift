//
//  LineSpacingType.swift
//  TivBible
//
//  Created by Isaac Iniongun on 21/06/2023.
//

import DeviceKit
import SwiftUI

enum LineSpacingType: String {
    case small, normal, large
    
    var value: CGFloat {
        switch self {
        case .small:
            return currentDevice.isPhone ? 4 : 6
        case .normal:
            return currentDevice.isPhone ? 6 : 8
        case .large:
            return currentDevice.isPhone ? 8 : 10
        }
    }
}
