//
//  MapViewController.swift
//  YandexMapKit
//
//  Created by Vadim Em on 19.05.2025.
//

import UIKit
import YandexMapsMobile
import SnapKit

class MapViewController: UIViewController {
    
    private let mapView = YMKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDefaultLocation()
    }
    
    private func setDefaultLocation() {
        let tashkent = YMKPoint(latitude: 41.3111, longitude: 69.2797)
        move(to: tashkent)
    }
    
    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func move(to location: YMKPoint) {
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: location, zoom: 17, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5),
            cameraCallback: nil
        )
    }
}
