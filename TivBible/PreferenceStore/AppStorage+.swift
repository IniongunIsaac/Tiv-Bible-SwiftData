//
//  AppStorage+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftUI

extension AppStorage {
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == Bool {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == Int {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == Double {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == URL {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == String {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == Data {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
    
    init(wrappedValue: Value, _ key: PreferenceStoreKey, store: UserDefaults? = nil) where Value == UUID {
        self.init(wrappedValue: wrappedValue, key.rawValue, store: store)
    }
}

extension UUID: RawRepresentable {
    public var rawValue: String {
        self.uuidString
    }

    public typealias RawValue = String

    public init?(rawValue: RawValue) {
        self.init(uuidString: rawValue)
    }
}
