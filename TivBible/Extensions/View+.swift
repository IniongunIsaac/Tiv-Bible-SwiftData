//
//  View+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftUI

extension View {
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        if value {
            self
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    func showUnderline(_ value: Bool) -> some View {
        if value {
            self.underline(pattern: .dot)
        } else {
            self
        }
    }
}
