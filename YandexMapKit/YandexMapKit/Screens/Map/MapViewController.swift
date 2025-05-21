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
import SwiftMessages

class MapViewController: UIViewController {
    
    private let locationManager = LocationManager()
    private var searchManager: SearchManager = SearchManager()
    
    private let mapView = YMKMapView()
    private let searchBar = UISearchBar()
    private let mapRouter: MapRouter = MapRouter()
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
    
    private let pin: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pin")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDefaultLocation()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.placeholder = "Поиск"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        searchBar.addGestureRecognizer(tapGesture)
        searchBar.searchTextField.isUserInteractionEnabled = false
    }
    
    @objc func handleTap() {
        SwiftMessages.hide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.mapRouter.openSearch(callback: { [weak self] item in
                self?.searchBar.text = item.name
                if let point = item.geometry.first?.point {
                    self?.move(to: point)
                }
                self?.mapRouter.openMapObject(title: item.name, description: item.descriptionText)
            })
        })
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
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(64)
        }
        
        view.addSubview(myLocationButton)
        myLocationButton.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-24)
        }
        
        view.addSubview(pin)
        pin.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(73)
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

extension MapViewController {
    func onSearchResponse(_ response: YMKSearchResponse) {
        guard let first = response.collection.children.first?.obj else {
            return
        }
        let name = first.name
        let description = first.descriptionText
        mapRouter.openMapObject(title: name, description: description)
    }

    func onSearchError(_ error: Error) {
        print("error, ", error)
    }
}
