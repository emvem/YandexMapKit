//
//  SearchMessageView.swift
//  YandexMapKit
//
//  Created by Vadim Em on 20.05.2025.
//

import UIKit
import SnapKit
import SwiftMessages

class SearchMessageView: MessageView {
    
    private let indicatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 208/255, green: 207/255, blue: 207/255, alpha: 1)
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    let cornerBackgroundView = CornerRoundingView(frame: .zero)
    
    var completion: (() -> Void)?
    
    init(completion: (() -> Void)?) {
        self.completion = completion
        super.init(frame: .zero)

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
        
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(104)
            $0.height.equalTo(500)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        
    }
}

extension SearchMessageView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseId, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
}
