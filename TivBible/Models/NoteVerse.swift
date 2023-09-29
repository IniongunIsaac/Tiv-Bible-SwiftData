//
//  NoteVerse.swift
//  TivBible
//
//  Created by Isaac Iniongun on 29/06/2023.
//

//import Foundation
//import SwiftData
//
//@Model
//final class NoteVerse {
//    @Attribute(.unique) var id: String
//    var title: String
//    var text: String
//    var number: Int
//    var highlightColor: String
//    var highlightDate: Date?
//    var isBookmarked: Bool
//    var bookmarkDate: Date?
//    var chapter: Chapter?
//    
//    init(id: String = UUID().uuidString,
//        title: String,
//        text: String,
//        number: Int,
//        highlightColor: String = "",
//        highlightDate: Date? = nil,
//        isBookmarked: Bool = false,
//        chapter: Chapter? = nil,
//        bookmarkDate: Date? = nil
//    ) {
//        self.id = id
//        self.title = title
//        self.text = text
//        self.number = number
//        self.highlightColor = highlightColor
//        self.highlightDate = highlightDate
//        self.isBookmarked = isBookmarked
//        self.chapter = chapter
//        self.bookmarkDate = bookmarkDate
//    }
//    
//    init(verse: Verse) {
//        self.id = verse.id
//        self.title = verse.title
//        self.text = verse.text
//        self.number = verse.number
//        self.highlightColor = verse.highlightColor
//        self.highlightDate = verse.highlightDate
//        self.isBookmarked = verse.isBookmarked
//        self.chapter = verse.chapter
//        self.bookmarkDate = verse.bookmarkDate
//    }
//    
//}
//
//extension Array where Element == NoteVerse {
//    var groups: [String] {
//        let numbers = sorted { $0.number < $1.number }.map { $0.number }
//        var left: Int?
//        var right: Int?
//        var groups = [String]()
//
//        for index in (numbers.first ?? 0)...(numbers.last ?? 0) + 1 {
//            if numbers.contains(index) {
//                if left == nil {
//                    left = index
//                } else {
//                    right = index
//                }
//            } else {
//                guard let leftx = left else { continue }
//                
//                if let right = right {
//                    groups.append("\(leftx)-\(right)")
//                } else {
//                    groups.append("\(leftx)")
//                }
//                left = nil
//                right = nil
//            }
//        }
//        
//        return groups
//    }
//    
//    var shareableText: String {
//        sorted { $0.number < $1.number }.map { "v\($0.number). \($0.text)" }.joined(separator: "\n")
//    }
//}
