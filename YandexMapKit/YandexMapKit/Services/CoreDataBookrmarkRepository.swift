//
//  CoreDataBookrmarkRepository.swift
//  YandexMapKit
//
//  Created by Vadim Em on 21.05.2025.
//

import Foundation
import CoreData

class CoreDataBookrmarkRepository: BookmarkRepository {
    let coreDataManager: CoreDataManager = CoreDataManager.shared
    
    func saveBookmark(bookmark: Bookmark) {
        let context = coreDataManager.context
        let mapObject = MapObject(context: context)
        mapObject.title = bookmark.title
        mapObject.subtitle = bookmark.subtitle
        mapObject.id = UUID().uuidString
        mapObject.lat = bookmark.latitude ?? 0.0
        mapObject.lon = bookmark.longitude ?? 0.0

        do {
            try context.save()
        } catch {
            print("Save error: \(error)")
        }
    }
    
    func getBookmarks() -> [Bookmark] {
        let request: NSFetchRequest<MapObject> = MapObject.fetchRequest()
        do {
            let mapObjects = try coreDataManager.context.fetch(request)
            return mapObjects.map {
                Bookmark(title: $0.title,
                         subtitle: $0.subtitle,
                         latitude: $0.lat,
                         longitude: $0.lon)
            }
        } catch {
            print("Fetch error: \(error)")
        }
        return []
    }
}
