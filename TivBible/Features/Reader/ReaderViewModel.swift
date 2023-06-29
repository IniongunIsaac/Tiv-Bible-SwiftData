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
    var versesNotes: String = ""
    var notesTokens = [NoteToken]()
    private var currentChapter: Chapter? = nil
    var errorMessage: String = ""
    
    private let preferenceStore = PreferenceStore()
    private let modelContainer = try! ModelContainer(for: Constants.dataModels)
    
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
            currentChapter = chapter
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
        let sortedVerses = selectedVerses.sorted { $0.number < $1.number }
        let groups = sortedVerses.groups
        
        selectedVersesText = "\(bookNameAndChapterNumber):\(groups.joined(separator: ", "))"
        shareableSelectedVersesText = "\(bookNameAndChapterNumber):\n\(sortedVerses.map { "v\($0.number). \($0.text)" }.joined(separator: "\n"))"
        generateNoteTokens(sortedVerses: sortedVerses, groups: groups)
    }
    
    private func generateNoteTokens(sortedVerses: [Verse], groups: [String]) {
        notesTokens = groups.map { group in
            let reference = "\(bookNameAndChapterNumber):\(group)".uppercased()
            
            if group.contains("-") {
                let indexes = group.components(separatedBy: "-")
                let startIndex = Int(indexes[0])!
                let endIndex = Int(indexes[1])!
                
                var texts = [String]()
                for index in startIndex ... endIndex {
                    if let verseText = sortedVerses.first(where: { $0.number == index })?.text {
                        texts.append("v\(index). \(verseText)")
                    }
                }
                
                let text = texts.joined(separator: "\n\n")
                return NoteToken(text: text, reference: reference)
            } else {
                let index = Int(group)!
                let verseText = sortedVerses.first(where: { $0.number == index })?.text ?? ""
                return NoteToken(text: verseText, reference: reference)
            }
        }
    }
    
    func setHighlights(_ colorHex: ColorHex) {
        selectedVerses.forEach {
            $0.highlightColor = colorHex.rawValue
            $0.highlightDate = Date()
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
            $0.highlightDate = nil
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
        selectedVerses.forEach {
            $0.isBookmarked = true
            $0.bookmarkDate = Date()
        }
        refreshVerses()
    }
    
    @MainActor
    func saveNotes() {
        let newNote = Note(verses: selectedVerses.noteVerses.sorted { $0.number < $1.number },
                           comment: versesNotes)
        context.insert(newNote)
        versesNotes = ""
        notesTokens = []
        toastMessage = "Success!"
    }
    
    @MainActor
    func getNextOrPreviousChapterVerses(type: NextButtonType) {
        guard let currentChapter, let currentBook = currentChapter.book else {
            errorMessage = "Something isn't right!"
            return
        }
        
        let chapterNumber = currentChapter.number
        
        switch type {
        case .next:
            guard let nextChapter = currentBook.chapters.first(where: { $0.number == chapterNumber + 1 }) else {
                errorMessage = "You're on the last chapter!"
                return
            }
            preferenceStore.currentChapterUUID = nextChapter.id
        case .previous:
            guard let previousChapter = currentBook.chapters.first(where: { $0.number == chapterNumber - 1 }) else {
                errorMessage = "You're on the first chapter!"
                return
            }
            preferenceStore.currentChapterUUID = previousChapter.id
        }
    }
}
