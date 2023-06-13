//
//  String+.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import Foundation

extension String {
    var cleanVerse: String {
        components(separatedBy: .whitespacesAndNewlines).joined(separator: " ")
    }
}
