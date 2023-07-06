//
//  Verse.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import Foundation
import SwiftData
import UIKit
import SwiftUI

@Model
final class Verse {
    @Attribute(.unique) var id: String
    var title: String
    var text: String
    var number: Int
    var highlightColor: String
    var highlightDate: Date?
    var isBookmarked: Bool
    var bookmarkDate: Date?
    var chapter: Chapter?
    
    @Transient
    var isSelected: Bool = false
    
    init(id: String = UUID().uuidString,
        title: String,
        text: String,
        number: Int,
        highlightColor: String = "",
        highlightDate: Date? = nil,
        isBookmarked: Bool = false,
        chapter: Chapter? = nil,
        bookmarkDate: Date? = nil
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.number = number
        self.highlightColor = highlightColor
        self.highlightDate = highlightDate
        self.isBookmarked = isBookmarked
        self.chapter = chapter
        self.bookmarkDate = bookmarkDate
    }
    
    init(verse: NoteVerse) {
        self.id = verse.id
        self.title = verse.title
        self.text = verse.text
        self.number = verse.number
        self.highlightColor = verse.highlightColor
        self.highlightDate = verse.highlightDate
        self.isBookmarked = verse.isBookmarked
        self.chapter = verse.chapter
        self.bookmarkDate = verse.bookmarkDate
    }
    
    func attrText(fontSize: Double, fontName: String) -> AttributedString {
        var numberDotAttrContainer = AttributeContainer()
        numberDotAttrContainer.baselineOffset = [13, 14, 15].contains(fontSize) ? 3 : 5
        numberDotAttrContainer.font = font(name: fontName, size: 10)
        let numberDotAttr = AttributedString("\(number). ", attributes: numberDotAttrContainer)
        
        var textAttrContainer = AttributeContainer()
        textAttrContainer.underlineStyle = .thick
        textAttrContainer.underlineColor = .red
        textAttrContainer.font = font(name: fontName, size: fontSize)
        
        if highlightColor.isNotEmpty {
            textAttrContainer.backgroundColor = highlightColor.color
        }
        let textAttr = AttributedString(text, attributes: textAttrContainer)
        
        //TODO: find out why paragraphs are not working. Could this be a Beta issue?
        /*var newContainer = AttributeContainer()
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 20
        paragraphStyle.paragraphSpacingBefore = 30
        paragraphStyle.lineSpacing = 20
        newContainer.paragraphStyle = paragraphStyle
        
        var finalAttrText = numberDotAttr + textAttr
        finalAttrText.mergeAttributes(newContainer)*/
        
        return numberDotAttr + textAttr
    }
    
    private func font(name: String, size: Double) -> Font {
        name.insensitiveEquals("system") ? .system(size: size, design: .rounded) : .custom(name, size: size)
    }
    
    var reference: String {
        guard let chapter, let book = chapter.book else {
            return ""
        }
        return "\(book.name) \(chapter.number):\(number)".uppercased()
    }
    
    func contains(_ searchText: String) -> Bool {
        title.localizedCaseInsensitiveContains(searchText) || text.localizedCaseInsensitiveContains(searchText)
    }
    
    var shareableText: String {
        "\(reference)\n\(text)"
    }
}

extension Array where Element == Verse {
    /// Returns formatted numbers like: [1, 2-4, 1‚1, 15-23] for an array of verses
    var groups: [String] {
        let numbers = self.sorted { $0.number < $1.number }.map { $0.number }
        var left: Int?
        var right: Int?
        var groups = [String]()

        for index in (numbers.first ?? 0)...(numbers.last ?? 0) + 1 {
            if numbers.contains(index) {
                if left == nil {
                    left = index
                } else {
                    right = index
                }
            } else {
                guard let leftx = left else { continue }
                
                if let right = right {
                    groups.append("\(leftx)-\(right)")
                } else {
                    groups.append("\(leftx)")
                }
                left = nil
                right = nil
            }
        }
        
        return groups
    }
    
    var shareableText: String {
        map { "v\($0.number). \($0.text)" }.joined(separator: "\n")
    }
    
    var noteVerses: [NoteVerse] {
        map(NoteVerse.init)
    }
}
