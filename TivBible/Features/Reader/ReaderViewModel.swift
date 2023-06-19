//
//  ReaderViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 13/06/2023.
//

import Foundation
import SwiftData

@Observable
final class ReaderViewModel {
    var bookNameAndChapterNumber: String = ""
    var verses = [Verse]()
    private var selectedVerses: [Verse] {
        verses.filter { $0.isSelected }
    }
    var showVerseSelectionActions: Bool {
        selectedVerses.isNotEmpty
    }
    private var shareableSelectedVersesText: String = ""
    var selectedVersesText: String = ""
    var toastMessage: String = ""
    
    private let preferenceStore = PreferenceStore()
    private let modelContainer = try! ModelContainer(for: [Book.self, Chapter.self, Verse.self])
    @MainActor
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    @MainActor
    func getVerses() {
        let chapterID = preferenceStore.currentChapterUUID
        let predicate = #Predicate<Chapter> {
            $0.id == chapterID
        }
        
        var descriptor = FetchDescriptor(predicate: predicate)
        descriptor.fetchLimit = 1
        
        do {
            guard let chapter = (try context.fetch(descriptor)).first else {
                return
            }
            bookNameAndChapterNumber = chapter.bookNameAndChapterNumber
            verses = chapter.verses.sorted(by: { $0.number < $1.number })
        } catch {
            print("unable to get verses")
        }
    }
    
    func refreshVerses() {
        verses = verses
        updateSelectedVersesText()
    }
    
    private func updateSelectedVersesText() {
        let selectedVersesList = selectedVerses.sorted { $0.number < $1.number }
        let verses = selectedVersesList.map { $0.number }

        var left: Int?
        var right: Int?
        var groups = [String]()

        for index in (verses.first ?? 0)...(verses.last ?? 0) + 1 {
            if verses.contains(index) {
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
        
        selectedVersesText = "\(bookNameAndChapterNumber.replacingOccurrences(of: ":", with: " ")) : \(groups.joined(separator: ", "))"
        shareableSelectedVersesText = "\(bookNameAndChapterNumber):\n\(selectedVersesList.map { "v\($0.number). \($0.text)" }.joined(separator: "\n"))"
    }
    
    func setHighlights(_ colorHex: ColorHex) {
        selectedVerses.forEach {
            $0.highlightColor = colorHex.rawValue
        }
        refreshVerses()
    }
    
    func unselectedVerses() {
        verses.forEach {
            $0.isSelected = false
        }
        refreshVerses()
    }
    
    func removeHighlights() {
        selectedVerses.forEach {
            $0.highlightColor = ""
        }
        refreshVerses()
    }
    
    func didTapVerseAction(_ action: VerseTapAction) {
        switch action {
        case .share:
            shareableSelectedVersesText.share()
        case .bookmark:
            setBookmarks()
            toastMessage = "Bookmarked!"
        case .copy:
            toastMessage = "Copied!"
            shareableSelectedVersesText.copyToClipboard()
        case .takeNotes:
            break
        }
    }
    
    func setBookmarks() {
        verses.forEach {
            $0.isBookmarked = true
            $0.bookmarkDate = Date()
        }
        refreshVerses()
    }
}
