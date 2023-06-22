//
//  DisclosureGroupExpansionHandler.swift
//  TivBible
//
//  Created by Isaac Iniongun on 22/06/2023.
//

import SwiftUI

final class DisclosureGroupExpansionHandler<T: Equatable>: ObservableObject {
    @Published private (set) var expandedItem: T?

    func isExpanded(_ item: T) -> Binding<Bool> {
        return Binding(
            get: { item == self.expandedItem },
            set: { self.expandedItem = $0 == true ? item : nil }
        )
    }

    func toggleExpanded(for item: T) {
        self.expandedItem = self.expandedItem == item ? nil : item
    }
}
