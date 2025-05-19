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
        
        view.addSubview(mapView)
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
