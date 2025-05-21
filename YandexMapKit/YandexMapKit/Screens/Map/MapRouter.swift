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
    func openMapObject(title: String?, description: String?) {
        let messageView = MapObjectMessageView(title: title,
                                               description: description,
                                               completion: {
            SwiftMessages.hide()
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
