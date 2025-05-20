//
//  LocationManager.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation() -> CLLocation? {
        return locationManager?.location
    }
}
