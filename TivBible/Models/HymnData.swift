//
//  HymnData.swift
//  TivBible
//
//  Created by Isaac Iniongun on 02/07/2023.
//

import Foundation

struct HymnData: Codable {
    let title: String
    let chorus: String
    let verses: [String]
}
