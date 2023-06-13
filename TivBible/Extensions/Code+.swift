//
//  Code+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation

extension Collection {
    var isNotEmpty: Bool {
        !isEmpty
    }
}

@discardableResult func with<T>(_ it: T, f:(T) -> ()) -> T {
    f(it)
    return it
}

extension Sequence {
    func distinctBy<A: Hashable>(by selector: (Iterator.Element) -> A) -> [Iterator.Element] {
        var set: Set<A> = []
        var list: [Iterator.Element] = []

        forEach { e in
            let key = selector(e)
            if set.insert(key).inserted {
                list.append(e)
            }
        }

        return list
    }
}
