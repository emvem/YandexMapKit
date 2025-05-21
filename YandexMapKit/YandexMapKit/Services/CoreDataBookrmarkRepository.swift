//
//  CoreDataBookrmarkRepository.swift
//  YandexMapKit
//
//  Created by Vadim Em on 21.05.2025.
//

import Foundation

class CoreDataBookrmarkRepository: BookmarkRepository {
    let coreDataManager: CoreDataManager = CoreDataManager()
    
    func saveBookmark(bookmark: Bookmark) {
        
    }
    
    func getBookmarks() -> [Bookmark] {
        return []
    }
}
