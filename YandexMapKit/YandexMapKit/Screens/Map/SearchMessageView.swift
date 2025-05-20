//
//  SearchMessageView.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import SnapKit
import SwiftMessages
import YandexMapsMobile

class SearchMessageView: MessageView {
    
    private let indicatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208/255, green: 207/255, blue: 207/255, alpha: 1)
        view.layer.cornerRadius = 2
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Поиск"
        return searchBar
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let cornerBackgroundView = CornerRoundingView(frame: .zero)
    
    private var completion: (() -> Void)?
    private var searchManager: YMKSearchManager?
    private var searchSession: YMKSearchSession?
    
    private var searchItems: [YMKGeoObject] = []
    
    init(completion: (() -> Void)?) {
        self.completion = completion
        
        super.init(frame: .zero)

        searchManager = YMKSearchFactory.instance().createSearchManager(with: .combined)
        configureUI()
    }
    
    @objc private func continueButtonTap() {
        completion?()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundView = cornerBackgroundView
        cornerBackgroundView.backgroundColor = UIColor.white

        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.reuseId)
        
        addSubview(cornerBackgroundView)
        cornerBackgroundView.addSubview(searchBar)
        cornerBackgroundView.addSubview(indicatorLine)
        cornerBackgroundView.addSubview(tableView)
        
        cornerBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        indicatorLine.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.width.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(12)
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().offset(32)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(48)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(104)
            $0.height.equalTo(500)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension SearchMessageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseId, for: indexPath) as! SearchCell
        let item = searchItems[indexPath.row]
        cell.configureView(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}

extension SearchMessageView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let responseHandler = {(searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            if let response = searchResponse {
                self.onSearchResponse(response)
            } else {
                self.onSearchError(error!)
            }
        }
        
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
            withText: searchBar.text ?? "",
            geometry: YMKGeometry(polygon: polygon),
            searchOptions: YMKSearchOptions(),
            responseHandler: responseHandler)
        
    }
    
    func onSearchResponse(_ response: YMKSearchResponse) {
        searchItems = response.collection.children.compactMap { $0.obj }
        tableView.reloadData()
    }

    func onSearchError(_ error: Error) {
        print("error, ", error)
    }
    
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

}
