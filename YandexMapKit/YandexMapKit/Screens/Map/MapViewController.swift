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
    private var searchManager: YMKSearchManager?
    private var searchSession: YMKSearchSession?
    
    private let mapView = YMKMapView()
    private lazy var myLocationButton: UIButton = {
        let action: UIAction = UIAction { [weak self] _ in
            
            self?.openSearch()
//            guard let location = self?.locationManager.getCurrentLocation() else {
//                return
//            }
//            
//            let lat = location.coordinate.latitude
//            let lon = location.coordinate.longitude
//            self?.move(to: YMKPoint(latitude: lat, longitude: lon))
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
        
        searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)

        setupViews()
        setDefaultLocation()
        
        mapView.mapWindow.map.addCameraListener(with: self)
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
    
    func getAddress(for point: YMKPoint) {
        searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)
    }
}

extension MapViewController: YMKMapCameraListener {
    func onCameraPositionChanged(with map: YMKMap, cameraPosition: YMKCameraPosition, cameraUpdateReason: YMKCameraUpdateReason, finished: Bool) {
        if finished {
            let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
                if let response = searchResponse {
                    self.onSearchResponse(response)
                } else {
                    self.onSearchError(error!)
                }
            }

            searchSession = searchManager!.submit(with: map.cameraPosition.target,
                                                  zoom: 17,
                                                  searchOptions: YMKSearchOptions(),
                                                  responseHandler: responseHandler)
        } else {
            SwiftMessages.hide()
        }
    }
    
    func onSearchResponse(_ response: YMKSearchResponse) {
        let mapObjects = mapView.mapWindow.map.mapObjects
        mapObjects.clear()
        guard let first = response.collection.children.first?.obj else {
            return
        }
        let name = first.name
        let description = first.descriptionText
        openMapObject(title: name, description: description)
    }

    func onSearchError(_ error: Error) {
        print("error, ", error)
    }
}

extension MapViewController {
    func openMapObject(title: String?, description: String?) {
        let messageView = MapObjectMessageView(title: title,
                                               description: description,
                                               completion: {
            print("completion")
            SwiftMessages.hide()
        })
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.presentationStyle = .bottom
        config.duration = .forever
        SwiftMessages.show(config: config, view: messageView)
    }
    
    func openSearch() {
        let messageView = SearchMessageView(completion: {
            print("completion")
            SwiftMessages.hide()
        })
        var config = SwiftMessages.Config()
        config.presentationContext = .window(windowLevel: .statusBar)
        config.presentationStyle = .bottom
        config.duration = .forever
        config.dimMode = .gray(interactive: true)
        SwiftMessages.show(config: config, view: messageView)
    }
}
