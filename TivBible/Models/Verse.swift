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
    var chapter: Chapter?
    
    @Transient
    var isSelected: Bool = false
    
    init(id: String = UUID().uuidString,
        title: String,
        text: String,
        number: Int,
        highlightColor: String = "",
        chapter: Chapter? = nil
    ) {
        self.id = id
        self.title = title
        self.text = text
        self.number = number
        self.highlightColor = highlightColor
        self.chapter = chapter
    }
    
    var attrText: AttributedString {
        var numberDotAttrContainer = AttributeContainer()
        numberDotAttrContainer.baselineOffset = 6
        numberDotAttrContainer.font = .gentiumPlus(.bold, size: 10)
        let numberDotAttr = AttributedString("\(number). ", attributes: numberDotAttrContainer)
        
        var textAttrContainer = AttributeContainer()
        textAttrContainer.underlineStyle = .thick
        textAttrContainer.underlineColor = .red
        if highlightColor.isNotEmpty {
            textAttrContainer.backgroundColor = highlightColor.color
        }
        let textAttr = AttributedString(text, attributes: textAttrContainer)
        
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
}
