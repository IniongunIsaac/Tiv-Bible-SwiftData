//
//  NoteToken.swift
//  TivBible
//
//  Created by Isaac Iniongun on 20/06/2023.
//

import Foundation

struct NoteToken: Identifiable {
    let id = UUID()
    let text: String
    let reference: String
}
