//
//  AppRouter.swift
//  YandexMapKit
//
//  Created by Vadim Em on 21.05.2025.
//

import UIKit
import YandexMapsMobile

class AppRouter {
    weak var tabBarController: UITabBarController?
    
    @MainActor func openMapObject(mapObject: YMKGeoObject) {
        tabBarController?.selectedIndex = 1
        let mapVC = tabBarController?.selectedViewController as! MapViewController
        mapVC.openMapObject(obj: mapObject)
    }
}
