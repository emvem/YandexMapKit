//
//  SearchManager.swift
//  YandexMapKit
//
//  Created by Vadim Em on 21.05.2025.
//

import YandexMapsMobile
import Foundation

class SearchManager {
    private var searchManager: YMKSearchManager?
    private var searchSession: YMKSearchSession?
    
    init() {
        searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)
    }
    
    func search(text: String, responseHandler: @escaping YMKSearchSessionResponseHandler) {
        let points: [YMKPoint] = [
            YMKPoint(latitude: 41.3669, longitude: 69.1951),
            YMKPoint(latitude: 41.3710, longitude: 69.3447),
            YMKPoint(latitude: 41.1981, longitude: 69.3506),
            YMKPoint(latitude: 41.1865, longitude: 69.1973),
            YMKPoint(latitude: 41.3669, longitude: 69.1951)
        ]

        let linearRing = YMKLinearRing(points: points as [YMKPoint])
        let polygon = YMKPolygon(outerRing: linearRing, innerRings: [])
        
        searchSession = searchManager?.submit(
            withText: text,
            geometry: YMKGeometry(polygon: polygon),
            searchOptions: YMKSearchOptions(),
            responseHandler: responseHandler)
    }
    
    func search(place: YMKPoint, zoom: NSNumber, responseHandler: @escaping YMKSearchSessionResponseHandler) {
        searchSession = searchManager?.submit(with: place,
                                              zoom: zoom,
                                              searchOptions: YMKSearchOptions(),
                                              responseHandler: responseHandler)

    }
}
