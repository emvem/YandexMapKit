//
//  MapViewController.swift
//  YandexMapKit
//
//  Created by Vadim Em on 19.05.2025.
//

import UIKit
import YandexMapsMobile
import SnapKit
import CoreLocation

class MapViewController: UIViewController {
    
    private let locationManager = LocationManager()
    
    private let mapView = YMKMapView()
    private lazy var myLocationButton: UIButton = {
        let action: UIAction = UIAction { [weak self] _ in
            guard let location = self?.locationManager.getCurrentLocation() else {
                return
            }
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            self?.move(to: YMKPoint(latitude: lat, longitude: lon))
        }
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        let button = UIButton(configuration: configuration, primaryAction: action)
        button.backgroundColor = .white
        button.layer.cornerRadius = 32
        button.setImage(UIImage(named: "current_location"), for: .normal)
        return button
    }()

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
        
        view.addSubview(myLocationButton)
        myLocationButton.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
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
