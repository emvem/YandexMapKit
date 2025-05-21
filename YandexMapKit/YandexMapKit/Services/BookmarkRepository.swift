//
//  BookmarkRepository.swift
//  YandexMapKit
//
//  Created by Vadim Em on 21.05.2025.
//

import Foundation

protocol BookmarkRepository {
    func saveBookmark(bookmark: Bookmark)
    func getBookmarks() -> [Bookmark]
}
