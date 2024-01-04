//
//  NextButton.swift
//  TivBible
//
//  Created by Isaac Iniongun on 23/06/2023.
//

import SwiftUI

enum NextButtonType {
    case next
    case previous
    
    var iconName: String {
        switch self {
        case .next:
            return "chevron.right.circle.fill"
        case .previous:
            return "chevron.left.circle.fill"
        }
    }
}

struct NextButton: View {
    
    private enum Constants {
        static let size: Double = 38
        static let horizontalPadding: Double = 20
        static let verticalPadding: Double = 40
    }
    
    var type: NextButtonType
    var action: VoidAction? = nil
    
    var body: some View {
        Button {
            action?()
        } label: {
            Image(systemName: type.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: Constants.size, height: Constants.size)
                .padding(.horizontal, Constants.horizontalPadding)
                .padding(.vertical, Constants.verticalPadding)
        }
        .tint(.darkGray)
    }
}

#Preview("NextButton") {
    NextButton(type: .next)
}
