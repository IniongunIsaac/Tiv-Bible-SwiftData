//
//  TivBibleData.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation

struct TivBibleData: Codable {
    let book: String
    let chapter: Int
    let verse: Int
    let text: String
    let title: String
    let testament: Int
    let orderNo: Int
}
