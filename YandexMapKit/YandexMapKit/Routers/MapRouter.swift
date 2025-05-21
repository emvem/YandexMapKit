//
//  MapRouter.swift
//  YandexMapKit
//
//  Created by Vadim Em on 21.05.2025.
//

import Foundation
import SwiftMessages
import YandexMapsMobile

@MainActor
class MapRouter {
    
    private var bookmarkRepository: BookmarkRepository = CoreDataBookmarkRepository()

    func openMapObject(mapObject: YMKGeoObject) {
        let messageView = MapObjectMessageView(mapObject: mapObject,
                                               completion: { [weak self] obj in
            SwiftMessages.hide()
            let bookmark = Bookmark(title: obj.name, subtitle: obj.descriptionText, latitude: nil, longitude: nil)
            self?.bookmarkRepository.saveBookmark(bookmark: bookmark)
        })
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.presentationStyle = .bottom
        config.duration = .forever
        SwiftMessages.show(config: config, view: messageView)
    }

    func openSearch(callback: @escaping (YMKGeoObject) -> Void) {
        let messageView = SearchMessageView(completion: { item in
            SwiftMessages.hide()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                callback(item)
            })
        })
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.presentationStyle = .bottom
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: messageView)
    }

}
