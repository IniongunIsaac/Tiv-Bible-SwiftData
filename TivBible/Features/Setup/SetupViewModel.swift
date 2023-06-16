//
//  SetupViewModel.swift
//  TivBible
//
//  Created by Isaac Iniongun on 12/06/2023.
//

import SwiftUI
import SwiftData

@MainActor
final class SetupViewModel: ObservableObject {
    @Published var dbInitializationInProgress: Bool = false
    @Published private var preferenceStore = PreferenceStore()
    
    private let modelContainer = try! ModelContainer(for: [Book.self, Chapter.self, Verse.self])
    private var context: ModelContext {
        modelContainer.mainContext
    }
    
    // Saves Genesis 1 as the default chapter
    private func saveDefaultChapter() {
        let bookPredicate = #Predicate<Book> {
            $0.order == 1
        }
        var bookDesc = FetchDescriptor(predicate: bookPredicate)
        bookDesc.fetchLimit = 1
        let books = (try? context.fetch(bookDesc)) ?? []
        guard let book = books.first else {
            print("unable to get Genese")
            return
        }
        let chapters = book.chapters.sorted(by: { $0.number < $1.number })
        guard let chapterOne = chapters.first else {
            print("Unable to get Genese 1")
            return
        }
        preferenceStore.currentChapterUUID = chapterOne.id
    }
    
    func initializeDB() async {
        guard !preferenceStore.hasSetupDB else {
            print("we have setup DB")
            return }
        
        dbInitializationInProgress = true
        
        var bibleData = [TivBibleData]()
        
        do {
            bibleData = try await getBibleData() ?? []
        } catch {
            debugPrint("unable to get local bible data from json file \(error)")
        }
        
        guard bibleData.isNotEmpty else { return }
        
        Task() {
            let bibleBooks = bibleData.distinctBy { $0.book }.sorted { $0.orderNo < $1.orderNo }
            
            var books = [Book]()
            
            bibleBooks.forEach { book in
                
                let bookOccurrences = bibleData.filter { $0.book == book.book }
                
                let bookChapters = bookOccurrences.distinctBy { $0.chapter }
                
                let newBook = Book(
                    name: book.book.lowercased().capitalized,
                    order: book.orderNo,
                    testament: book.testament,
                    version: 0
                )
                
                var newChapters = [Chapter]()
                
                bookChapters.forEach { chapter in
                    
                    let bookChapterVerses = bookOccurrences.filter { $0.chapter == chapter.chapter }.distinctBy { $0.verse }
                    
                    let newChapter = Chapter(number: chapter.chapter, book: newBook)
                    
                    let verses = bookChapterVerses.map {
                        Verse(title: $0.title.cleanVerse,
                              text: $0.text.cleanVerse,
                              number: $0.verse,
                              chapter: newChapter)
                    }
                    
                    newChapter.verses = verses
                    newChapters.append(newChapter)
                    
                }
                
                newBook.chapters = newChapters
                books.append(newBook)
                
            }
            
            for book in books {
                context.insert(book)
            }
            
            saveDefaultChapter()
            
            preferenceStore.hasSetupDB = true
            dbInitializationInProgress = false
        }
    }
    
    private func getBibleData() async throws -> [TivBibleData]? {
        let task = Task {
            guard let jsonData = jsonData(from: "tivBibleData") else {
                throw TivBibleError.unableToLoadLocalJSON
            }
            
            do {
                return try jsonData.decode(into: [TivBibleData].self)
            } catch {
                throw TivBibleError.unableToDecodeData
            }
        }
        
        return try await task.value
    }
}
