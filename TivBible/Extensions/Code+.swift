//
//  Code+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import DeviceKit
import StoreKit

typealias VoidAction = (() -> Void)
typealias ArgumentAction<T> = ((T) -> Void)
let currentDevice = Device.current

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

extension Double {
    var int: Int {
        Int(self)
    }
}

extension Int {
    var cgfloat: CGFloat {
        CGFloat(self)
    }
}

func runAfter(_ delay: Double = 0.2, block: @escaping VoidAction) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        block()
    }
}

func runOnMainThread(action: @escaping () -> Void) {
    DispatchQueue.main.async {
        action()
    }
}

func runOnBackground(
    qos: DispatchQoS.QoSClass = .userInitiated,
    action: @escaping () -> Void
) {
    DispatchQueue.global(qos: qos).async {
        action()
    }
}

func rateApp() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    else {
        print("WindowScene not available!!!")
        return
    }
    SKStoreReviewController.requestReview(in: windowScene)
}
