//
//  PreferenceStore.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftUI

final class PreferenceStore: ObservableObject {
    @AppStorage(.hasSetupDB) var hasSetupDB: Bool = false
}
